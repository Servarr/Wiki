---
title: Lidarr Common Problems
description: Quick solutions to the most frequent Lidarr issues
published: true
date: 2025-09-17T20:30:00.000Z
tags: lidarr, troubleshooting, problems, mobile-friendly
editor: markdown
dateCreated: 2025-09-17T20:30:00.000Z
---

# Lidarr Common Problems

> **📱 Mobile Tip:** Use your browser's search (Ctrl+F) to quickly find your specific issue

## 🚀 Most Common Issues

### Can't Find Artist/Album
**Problem:** Artist or album doesn't show up in search

**Quick Solutions:**
1. **Check MusicBrainz:** Search [musicbrainz.org](https://musicbrainz.org) directly
2. **Add to MusicBrainz** if missing, then wait 1-2 days for sync
3. **Use MusicBrainz ID:** Add directly if you know the MBID
4. **Check spelling:** Try alternative spellings or names
5. **Look under labels/various artists** for compilations

**Common issues:** Missing from MusicBrainz, wrong spelling, various artists albums

---

### Album Import Issues
**Problem:** Albums won't import or match incorrectly

**Quick Solutions:**
1. **Check folder structure:** `Artist/Album/tracks` format
2. **Verify tags:** Ensure basic ID3 tags are present
3. **Manual import:** Use Activity → Queue → Manual Import
4. **Fix incorrect matches:** Unmonitor → re-add with correct album
5. **Check permissions:** Ensure Lidarr can read/write folders

**File naming:** Use proper tagging tools like MusicBrainz Picard

---

### Wanted Albums Never Download
**Problem:** Albums stay in wanted list forever

**Quick Solutions:**
1. **Manual search:** Album page → Search button
2. **Check indexers:** Verify they have music categories
3. **Test indexers:** System → Status for connection issues
4. **Quality profile:** May be too restrictive
5. **Enable missing search:** Use "Start search" when adding

**Remember:** Lidarr only monitors RSS feeds, doesn't search history

---

### Database Disk Image is Malformed
**Problem:** Lidarr won't start, shows database corruption error

**Quick Solutions:**
1. **First try:** Restore from System → Backup
2. **If no backup:** Use [database recovery tools](/useful-tools#recovering-a-corrupt-db)
3. **Last resort:** Delete `lidarr.db` (loses all settings)

**Prevention:** Enable automatic backups in Settings

---

### Artist Folder Naming Issues
**Problem:** Lidarr keeps trying to rename folders

**Quick Solutions:**
1. **Check naming format:** Settings → Media Management → Folder Naming
2. **Fix conflicting names:** Resolve duplicate artist folders
3. **Verify permissions:** Ensure Lidarr can rename folders
4. **Manual rename:** Bulk rename via Mass Editor
5. **Check for special characters** in artist names

---

## 🎵 Music-Specific Issues

### Various Artists Albums
**Problem:** Can't add compilation/various artists albums

**Solutions:**
1. **Search for album name** rather than "Various Artists"
2. **Check MusicBrainz** under specific release artists
3. **Use album MBID** if known
4. **Add via individual tracks** if necessary

### Singles and EPs Missing
**Problem:** Only studio albums show up

**Solutions:**
1. **Album Types:** Settings → Metadata → Album Types
2. **Enable singles/EPs** in monitoring options
3. **Check MusicBrainz** - may be categorized differently
4. **Search specifically** for EP/single names

### Wrong Album Matched
**Problem:** Album matched with incorrect release (wrong track count)

**Solutions:**
1. **Unmonitor current album**
2. **Search for correct release** on MusicBrainz
3. **Add by specific release MBID**
4. **Manual import** with correct metadata
5. **Use MusicBrainz Picard** to fix tags first

---

## 🔧 Technical Issues

### Ubuntu 22.04 Issues
**Problem:** Lidarr stopped working after Ubuntu update

**Solutions:**
1. **Install compatibility libraries:**
   ```
   sudo apt install libicu70
   ```
2. **Update Lidarr** to latest version
3. **Check .NET runtime** compatibility
4. **Review system logs** for specific errors

### Authentication Problems v2+
**Locked out after enabling auth:**
1. Edit `config.xml` in [AppData directory](/lidarr/appdata-directory)
2. Change `<AuthenticationMethod>` to `External`
3. Restart Lidarr
4. Reset authentication in Settings

> **v2+ Requirement:** Authentication is mandatory

### Remote File Access Issues
**Can't see files on network drives:**

**Linux:**
- NFS: Add `nolock` to mount options
- SMB: Add `nobrl` to mount options

**Windows:**
- Use UNC paths (`\\server\share`) not mapped drives
- Run Lidarr service as user with network access

### Mac Issues
**"Cannot be opened" error:**
1. **System Preferences** → **Security & Privacy**
2. Click **"Open Anyway"** next to Lidarr
3. **Sudden stop:** Usually database corruption, try restore

---

## 🔍 Search & Download Issues

### No Search Results
1. **Check music categories** in indexer settings
2. **Test indexers** for music content
3. **Try different search terms** (artist + album)
4. **Verify indexer supports** music searches
5. **Check logs** for indexer errors

### Downloads Not Importing
1. **Check download paths** match Lidarr expectations
2. **Verify file permissions** on music directories
3. **Review Activity** tab for import errors
4. **Check download client** category settings
5. **Ensure proper tagging** of music files

### Metadata Issues
1. **Enable metadata providers** in Settings
2. **Check MusicBrainz connectivity**
3. **Clear cache** if metadata seems stale
4. **Manual metadata refresh** for specific artists

---

## 🛠️ Quick Fixes

### Clear Cache and Refresh
**If metadata seems wrong:**
1. **Artist page** → Refresh Artist
2. **Mass Editor** → Refresh multiple artists
3. **System → Tasks** → Refresh Artist Info
4. **Clear browser cache** for UI issues

### Import Large Libraries
**For existing music collections:**
1. **Use proper folder structure** first
2. **Tag files** with MusicBrainz Picard
3. **Import small batches** to avoid timeouts
4. **Monitor progress** in Activity tab
5. **Fix issues** one artist at a time

### Sync Timing Issues
**Lists and metadata:**
- **MusicBrainz sync:** Daily updates
- **List sync:** 6-24 hour intervals (not configurable)
- **Manual refresh:** Use refresh buttons for immediate updates

---

## 📱 Mobile-Specific Tips

### Artist Management
- **Long press** artist cards for quick actions
- **Swipe gestures** where available
- **Landscape mode** for better album grid viewing
- **Pinch zoom** on album artwork

### Search and Discovery
- **Use search filters** effectively on mobile
- **Bookmark wanted** albums for easy access
- **Activity tab** shows current downloads
- **Calendar view** for release tracking

### Library Navigation
- **Artist index** with letter jumping
- **Sort options** optimized for touch
- **Quick actions** in slide-out menus

---

## 🆘 Still Need Help?

If your issue isn't listed here:

1. **Check the full [FAQ](/lidarr/faq)** for detailed explanations
2. **Search [troubleshooting guide](/lidarr/troubleshooting)** for advanced solutions
3. **Visit [Discord](https://lidarr.audio/discord)** or [Reddit](https://reddit.com/r/lidarr) for community help
4. **Check MusicBrainz** status and data quality

**When asking for help, always include:**
- Lidarr version
- Operating system
- Artist/album names and MusicBrainz IDs
- Error messages from logs
- Steps you've already tried

**For import issues, provide:**
- File structure examples
- Tag information (use MusicBrainz Picard to check)
- Manual import attempt results
- Any error messages from Activity tab