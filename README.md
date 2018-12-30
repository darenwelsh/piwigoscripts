# piwigoscripts
Scripts used in support of Piwigo

## To get files from my computer to my server
```bash
rsync -rvzhte ssh --progress "/Volumes/DW Untethered/Imagery/6DMII/" username@lebanon.dreamhost.com:/home/username/mysite.com/galleries/ --partial-dir=.rsync-partial
```

## piwigo_refresh.pl
Script originally from https://piwigo.org/ext/extension_view.php?eid=855 but customized for my use. This takes the files from my server directory and imports them into Piwigo (run frequently by cron).

## piwigo_vid_thumbs.pl
Modified copy of the piwigo_refresh.pl script, but using the VideoJS extension interface. This makes screenshot "posters" for video files in Piwigo (run frequently by cron).
