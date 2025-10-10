---
title: Prowlarr Common Problems
description: Quick solutions to the most frequent Prowlarr issues
published: true
date: 2025-09-17T20:30:00.000Z
tags: prowlarr, troubleshooting, problems, mobile-friendly
editor: markdown
dateCreated: 2025-09-17T20:30:00.000Z
---

# Prowlarr Common Problems

> **📱 Mobile Tip:** Use your browser's search (Ctrl+F) to quickly find your specific issue

## 🚀 Most Common Issues

### Indexer Won't Sync to Apps
**Problem:** Prowlarr not syncing indexers to Sonarr/Radarr

**Quick Solutions:**
1. **Check app connections:** Settings → Apps → Test
2. **Verify API keys** are correct in both directions
3. **Check indexer categories** match app requirements
4. **Force sync:** Apps → Full Sync
5. **Review logs:** System → Logs for sync errors

**Common causes:** API key mismatch, network issues, incompatible categories

---

### Indexer Authentication Failures
**Problem:** Private indexers failing with auth errors

**Quick Solutions:**
1. **Update cookies:** Copy fresh cookies from browser
2. **Check credentials:** Username/password for RSS key
3. **Verify indexer status:** May be down or changed auth
4. **Clear cache:** Remove old cached auth data
5. **Use FlareSolverr** for Cloudflare-protected sites

**Prevention:** Set up cookie monitoring or FlareSolverr integration

---

### Search Results Missing/Limited
**Problem:** Apps show fewer results than manual indexer search

**Quick Solutions:**
1. **Check categories:** Ensure indexer categories match app needs
2. **Review mapping:** Custom categories may not be mapped
3. **Test indexer directly:** Use Test button in indexer settings
4. **Check limits:** Some indexers have API rate limits
5. **Verify search parameters** in indexer definition

---

### Database Disk Image is Malformed
**Problem:** Prowlarr won't start, shows database corruption error

**Quick Solutions:**
1. **First try:** Restore from System → Backup
2. **If no backup:** Use [database recovery tools](/useful-tools#recovering-a-corrupt-db)
3. **Last resort:** Delete `prowlarr.db` (loses all settings)

**Prevention:** Enable automatic backups in Settings

---

### Can't Access from Other Computers
**Problem:** Prowlarr only works on localhost

**Quick Solution:**
1. **Run Prowlarr as administrator once** (opens firewall)
2. Access via `http://YOUR-IP:9696`
3. If port changed, repeat step 1

---

## 🔧 Indexer Management

### Adding Generic Indexers
**Torrent RSS feeds:**
- Use **"TorrentRSS"** indexer type
- Provide RSS feed URL
- Test before saving

**Newznab/Torznab indexers:**
- Use **"Generic Newznab"** or **"Generic Torznab"**
- Get API URL and key from indexer
- Configure categories appropriately

### Indexer Down or Maintenance
**Temporary failures:**
1. **Disable indexer** rather than delete
2. **Check indexer status** pages/Discord
3. **Re-enable when restored**
4. **Update URLs** if indexer moved domains

### FlareSolverr Integration
**For Cloudflare-protected indexers:**
1. **Install FlareSolverr** (Docker recommended)
2. **Settings → Indexers → Proxies**
3. **Add FlareSolverr proxy** (usually http://localhost:8191)
4. **Tag indexers** that need CloudFlare bypass
5. **Test connection** before enabling

---

## 🔄 App Sync Issues

### Full Sync vs Individual Sync
**Full Sync:**
- Removes indexers not in Prowlarr
- Adds all enabled indexers
- Updates all settings
- **Use carefully** - can remove manually added indexers

**Individual Sync:**
- Syncs specific indexers only
- Safer for mixed setups
- Preserves manual indexer additions

### Sync Settings Compared
**These settings are synced:**
- Indexer URL and API key
- Categories and mappings
- Priority and grab limits
- Enable/disable status
- Custom format tags

**Not synced:**
- Download client specific settings
- Individual app quality profiles
- Custom app-specific categories

### Common Sync Failures
1. **API connectivity:** Apps must reach Prowlarr
2. **Version compatibility:** Keep apps updated
3. **Category conflicts:** Apps reject incompatible categories
4. **Network issues:** Check firewalls and routing

---

## 🔧 Technical Issues

### Authentication Problems
**Locked out after enabling auth:**
1. Edit `config.xml` in [AppData directory](/prowlarr/appdata-directory)
2. Change `<AuthenticationMethod>` to `External`
3. Restart Prowlarr
4. Reset authentication in Settings

> **v1+ Requirement:** Authentication is mandatory

### Cookie Management
**For private trackers:**
1. **Browser extension:** Cookie exports (recommended)
2. **Manual copy:** From browser developer tools
3. **Regular updates:** Cookies expire frequently
4. **Monitor expiry:** Set alerts for critical indexers

### SSL/Certificate Issues
**HTTPS connection problems:**
1. **Disable SSL validation** for self-signed certificates
2. **Update certificate store** on your system
3. **Use HTTP** if HTTPS unavailable
4. **Check system time** - certificates are time-sensitive

---

## 🛠️ Quick Fixes

### Clear Indexer Cache
**If indexer behaves strangely:**
1. **Settings → Indexers**
2. **Edit problematic indexer**
3. **Clear cached data** or **Reset to defaults**
4. **Test connection** before saving

### Update Indexer Definitions
**For new features or fixes:**
1. **System → Updates**
2. **Check for Cardigann definition updates**
3. **Update indexer templates** when available
4. **Restart if prompted**

### Reset Statistics
**To clear history and stats:**
1. **History → Options**
2. **Set cleanup to 1 day**
3. **System → Tasks → Clean Up History**
4. **Run Housekeeping task**
5. **Reset cleanup period**

---

## 📱 Mobile-Specific Tips

### Indexer Management
- **Long press** indexer cards for quick actions
- **Swipe gestures** for enable/disable where available
- **Landscape mode** for better table viewing
- **Pinch zoom** on statistics and graphs

### App Sync Monitoring
- **Activity tab** shows sync status
- **Pull to refresh** to update app connections
- **Tap notifications** for detailed sync results

### Search Testing
- **Use search tab** to test indexers quickly
- **Filter by category** for relevant results
- **Compare results** across indexers easily

---

## 🆘 Still Need Help?

If your issue isn't listed here:

1. **Check the full [FAQ](/prowlarr/faq)** for detailed explanations
2. **Search [troubleshooting guide](/prowlarr/troubleshooting)** for advanced solutions
3. **Visit [Discord](https://prowlarr.com/discord)** or [Reddit](https://reddit.com/r/prowlarr) for community help
4. **Check indexer status** pages before reporting issues

**When asking for help, always include:**
- Prowlarr version
- Operating system
- Indexer name and type
- Error messages from logs
- App versions (Sonarr/Radarr/etc.)
- Steps you've already tried

**For indexer issues, provide:**
- Indexer test results
- Browser vs Prowlarr result comparison
- Cookie/authentication details (sanitized)
- Any recent indexer changes