#!/usr/bin/env node
/**
 * Add or update an entry in CloudronVersions.json (for CI when cloudron build is unavailable).
 * Usage: node scripts/update-cloudron-versions.mjs <docker-image-ref>
 */
import fs from 'node:fs';
import path from 'node:path';

const root = path.resolve(import.meta.dirname, '..');
const image = process.argv[2];
if (!image) {
  console.error('Usage: node scripts/update-cloudron-versions.mjs <docker-image>');
  process.exit(1);
}

const manifestPath = path.join(root, 'CloudronManifest.json');
const versionsPath = path.join(root, 'CloudronVersions.json');
const manifest = JSON.parse(fs.readFileSync(manifestPath, 'utf8'));

function readFileRef(value) {
  if (!value?.startsWith('file://')) return value;
  const filePath = path.join(root, value.slice(7));
  return fs.readFileSync(filePath, 'utf8');
}

function parseChangelog(filePath, version) {
  const data = fs.readFileSync(filePath, 'utf8');
  const baseVersion = version.replace(/-.*/, '');
  const lines = data.split('\n');
  let i = 0;
  for (; i < lines.length; i++) {
    if (lines[i] === `[${baseVersion}]`) break;
  }
  let changelog = '';
  for (i += 1; i < lines.length; i++) {
    if (lines[i] === '') continue;
    if (lines[i][0] === '[') break;
    changelog += `${lines[i]}\n`;
  }
  if (!changelog.trim()) throw new Error(`No changelog section for [${baseVersion}]`);
  return changelog.trim();
}

const resolved = {
  ...manifest,
  description: readFileRef(manifest.description),
  postInstallMessage: readFileRef(manifest.postInstallMessage),
  changelog: parseChangelog(path.join(root, 'CHANGELOG'), manifest.version),
  dockerImage: image,
};

const versionsRoot = JSON.parse(fs.readFileSync(versionsPath, 'utf8'));
const now = new Date().toUTCString();
const version = manifest.version;

if (versionsRoot.versions[version]) {
  versionsRoot.versions[version].manifest = resolved;
  versionsRoot.versions[version].ts = now;
  console.log(`Updated ${version} in CloudronVersions.json`);
} else {
  versionsRoot.versions[version] = {
    manifest: resolved,
    creationDate: now,
    ts: now,
    publishState: 'published',
  };
  console.log(`Added ${version} to CloudronVersions.json`);
}

fs.writeFileSync(versionsPath, `${JSON.stringify(versionsRoot, null, 4)}\n`);
