---
title: Sonarr Common Problems
description: Quick solutions to the most frequent Sonarr issues
published: true
date: 2025-09-17T20:30:00.000Z
tags: sonarr, troubleshooting, problems, faq
editor: markdown
dateCreated: 2025-09-17T20:30:00.000Z
---

# Sonarr Common Problems

> **💡 Tip:** Use your browser's search (Ctrl+F) to quickly find your specific issue

## 🚀 Most Common Issues

### Episode Not Found/Downloaded
**Problem:** Sonarr didn't grab an expected episode

**Quick Solutions:**
1. **Manual Search:** Click magnifying glass next to episode
2. **Check indexers:** System → Status for connection issues
3. **Review results:** Look for red exclamation marks (hover for reasons)
4. **Verify series type:** Standard vs Daily vs Anime

**Why this happens:** Sonarr only monitors RSS feeds, doesn't search entire indexer history.

---

### Series Won't Add/Search
**Problem:** Can't add series or "Unknown Series" error

**Quick Solutions:**
1. **Check TVDb:** Series must exist with English title
2. **Use TVDb ID:** Add by ID if search fails
3. **Wait for cache:** TVDb updates take 3-19 hours to sync
4. **Scene mapping:** Check [TheXEM](http://thexem.info) for numbering issues

**Common causes:** Non-English titles, new series, scene numbering differences

---

### Path Already Configured Error
**Problem:** "Path is configured for an existing series" error

**Quick Solutions:**
1. Go to **Series** → **Table View**
2. Add **Path** as a column (Options menu)
3. Sort by path and find the duplicate
4. Either delete or fix the conflicting series

**Common cause:** Importing library without correcting mismatched series

---

### Database Disk Image is Malformed
**Problem:** Sonarr won't start, shows database corruption error

**Quick Solutions:**
1. **First try:** Restore from System → Backup
2. **If no backup:** Use [database recovery tools](/useful-tools#recovering-a-corrupt-db)
3. **Last resort:** Delete `sonarr.db` (loses all settings)

> **v4 Note:** Database corruption during v4 upgrade means v3 database was already corrupt

---

### Can't Access from Other Computers
**Problem:** Sonarr only works on localhost

**Quick Solution:**
1. **Run Sonarr as administrator once** (opens firewall)
2. Access via `http://YOUR-IP:8989`
3. If port changed, repeat step 1

---

## 📺 Series & Episode Issues

### Scene Numbering Problems
**Problem:** Episodes import with wrong numbers (American Dad, Pokémon, etc.)

**Solutions:**
1. **Check [TheXEM](http://thexem.info)** for existing mappings
2. **Submit mapping request** if series not mapped
3. **Switch series type** (Standard ↔ Anime) as test
4. **Manual import** for problematic episodes

**Known problematic shows:** American Dad, Pokémon, Bleach, Money Heist

### TBA Episode Titles
**Problem:** Episodes show as "TBA" and won't import

**Solutions:**
1. **Wait 48 hours** after air date (auto-imports after)
2. **Manual import** if urgent
3. **Check TVDb** - update episode titles there
4. **Disable title requirement** in Settings → Importing

### Series Type Confusion
**Choose the right type:**
- **Standard:** S01E01 format (most shows)
- **Daily:** 2025-01-15 format (news, talk shows)
- **Anime:** Absolute episode numbers

---

## 🔧 Technical Issues

### Authentication Problems v4
**Locked out after v4 upgrade:**
1. Edit `config.xml` in [AppData directory](/sonarr/appdata-directory)
2. Change `<AuthenticationMethod>` to `External`
3. Restart Sonarr
4. Reset authentication in Settings

> **v4 Requirement:** Authentication is now mandatory

### Remote File Access Issues
**Can't see files on network drives:**

**Linux:**
- NFS: Add `nolock` to mount options
- SMB: Add `nobrl` to mount options

**Windows:**
- Use UNC paths (`\\server\share`) not mapped drives
- Run Sonarr service as user with network access

### Mac Specific Issues
**"Cannot be opened" error:**
1. **System Preferences** → **Security & Privacy**
2. Click **"Open Anyway"** next to Sonarr
3. **Alternative:** `chmod +x /Applications/Sonarr.app/Contents/MacOS/Sonarr`

---

## 🔍 Search & Download Issues

### Jackett /all Endpoint Problems
**Problem:** Using Jackett's `/all` endpoint causes issues

**Solution:**
1. **Add indexers individually** instead of using `/all`
2. **Switch to [Prowlarr](/prowlarr)** for better indexer management
3. **Never use** aggregate endpoints

### No Search Results
1. **Check indexer categories** in Settings
2. **Test indexers** individually
3. **Review series type** (Standard/Daily/Anime)
4. **Check scene mappings** on TheXEM

### Downloads Not Importing
1. **Check download client** connection and settings
2. **Verify matching paths** between client and Sonarr
3. **Review Activity** tab for import errors
4. **Check file permissions** on download directory

---

## 🛠️ Quick Fixes

### Refresh Issues
**Series info not updating:**
- **Manual refresh:** Series page → Refresh button
- **Auto refresh:** Runs every 12 hours (don't disable)
- **TVDb changes:** Take 3-19 hours to appear

### Clear Browser Cache
If UI behaves strangely:
1. **Incognito/Private mode** first
2. **Clear cache:** Ctrl+Shift+Del
3. **Whitelist domain** in ad blockers

### Update Issues
**Stuck on old version:**
1. **Settings** → **General** → **Updates**
2. Change **Branch** (main/develop)
3. **Save** and wait for next update check

> **v3 to v4:** Cannot upgrade directly, must install v4

---

## 📱 Mobile-Specific Tips

### Series Management
- **Long press** series posters for quick actions
- **Swipe** for additional options where available
- **Landscape mode** for better episode list viewing
- **Pinch zoom** on calendar and activity views

### Episode Search
- **Tap episode** for details and manual search
- **Use filters** in Wanted tab (Missing, Cut-off Unmet)
- **Activity tab** shows current downloads and history

### Calendar Navigation
- **Swipe left/right** to change weeks
- **Tap dates** to jump to specific days
- **Toggle views** between calendar and list

---

## 🆘 Still Need Help?

If your issue isn't listed here:

1. **Check the full [FAQ](/sonarr/faq)** for detailed explanations
2. **Search [troubleshooting guide](/sonarr/troubleshooting)** for advanced solutions
3. **Visit [Discord](https://discord.sonarr.tv)** or [Reddit](https://reddit.com/r/sonarr) for community help
4. **Review scene mapping** issues on [TheXEM](http://thexem.info)

**When asking for help, always include:**
- Sonarr version (v3 or v4)
- Operating system
- Error messages from logs
- Series name and episode details
- Steps you've already tried

**For scene numbering issues, provide:**
- Release name examples
- Expected vs actual episode numbers
- Series TVDb ID