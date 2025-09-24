---
title: Radarr Common Problems
description: Quick solutions to the most frequent Radarr issues
published: true
date: 2025-09-17T20:30:00.000Z
tags: radarr, troubleshooting, problems, faq
editor: markdown
dateCreated: 2025-09-17T20:30:00.000Z
---

# Radarr Common Problems

> **💡 Tip:** Use your browser's search (Ctrl+F) to quickly find your specific issue

## 🚀 Most Common Issues {.tabset}

### Quick Fixes

### Movie Added but Not Searched
**Problem:** Added a movie but Radarr didn't search for it

**Quick Solutions:**
1. ✅ Check the "Start search for missing movie" box when adding
2. Go to movie page → click **Search** button
3. Use **Wanted** tab → **Missing** to search multiple movies

**Why this happens:** Radarr only monitors RSS feeds by default, it doesn't search your entire indexer history.

---

### Path Already Configured Error
**Problem:** "Path is configured for an existing movie" error

**Quick Solutions:**
1. Go to **Movies** → **Table View**
2. Add **Path** as a column (Options menu)
3. Sort by path and find the duplicate
4. Either delete or fix the conflicting movie

**Common cause:** Importing library without correcting mismatched movies

---

### Database Disk Image is Malformed
**Problem:** Radarr won't start, shows database corruption error

**Quick Solutions:**
1. **First try:** Restore from System → Backup
2. **If no backup:** Use [database recovery tools](/useful-tools#recovering-a-corrupt-db)
3. **Last resort:** Delete `radarr.db` (loses all settings)

**Prevention:** Enable automatic backups in Settings

---

### Can't Access from Other Computers
**Problem:** Radarr only works on localhost

**Quick Solution:**
1. **Run Radarr as administrator once** (opens firewall)
2. Access via `http://YOUR-IP:7878`
3. If port changed, repeat step 1

---

### Mac Security Issues
**Problem:** "Cannot be opened because developer cannot be verified"

**Quick Solutions:**
1. **System Preferences** → **Security & Privacy**
2. Click **"Open Anyway"** next to Radarr
3. **Alternative:** Run `codesign --force --deep -s - /Applications/Radarr.app`

---

## 🔧 Technical Issues

### Authentication Problems
**Locked out after enabling auth:**
1. Edit `config.xml` in [AppData directory](/radarr/appdata-directory)
2. Change `<AuthenticationMethod>` to `External`
3. Restart Radarr
4. Reset authentication in Settings

### Remote File Access Issues
**Can't see files on network drives:**

**Linux:**
- NFS: Add `nolock` to mount options
- SMB: Add `nobrl` to mount options

**Windows:**
- Use UNC paths (`\\server\share`) not mapped drives
- Run Radarr service as user with network access

### VPN Problems
**Rate limiting or connection issues:**
- **Don't** put Radarr behind VPN
- Only put download client behind VPN
- Use [split tunneling](/vpn) if VPN required

---

## 🔍 Search & Download Issues

### No Search Results
1. **Check indexer status** in System → Status
2. **Test indexers** individually
3. **Verify movie exists** on TMDb
4. **Try manual search** on indexer websites

### Downloads Not Importing
1. **Check download client** connection
2. **Verify paths match** between client and Radarr
3. **Review Activity** tab for errors
4. **Check permissions** on download directory

### Quality/Custom Format Issues
1. **Check quality profile** settings
2. **Review custom formats** scoring
3. **Verify indexer categories** are correct
4. **Check delay profiles** for restrictions

---

## 🛠️ Quick Fixes

### Clear Browser Cache
If UI behaves strangely:
1. **Chrome:** Ctrl+Shift+Del
2. **Firefox:** Ctrl+Shift+Del
3. **Try incognito/private mode** first

### Reset Corrupt Config
1. Stop Radarr
2. Rename `config.xml` to `config.xml.backup`
3. Start Radarr (creates new config)
4. Reconfigure settings

### Update Issues
**Stuck on old version:**
1. **Settings** → **General** → **Updates**
2. Change **Branch** to desired version
3. **Save** and wait for next update check

---


## 🆘 Still Need Help?

If your issue isn't listed here:

1. **Check the full [FAQ](/radarr/faq)** for detailed explanations
2. **Search [troubleshooting guide](/radarr/troubleshooting)** for advanced solutions
3. **Visit [Discord](https://radarr.video/discord)** or [Reddit](https://reddit.com/r/radarr) for community help
4. **Review logs** in System → Logs before asking for help

**When asking for help, always include:**
- Radarr version
- Operating system
- Error messages from logs
- Steps you've already tried