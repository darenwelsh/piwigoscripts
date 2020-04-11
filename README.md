# piwigoscripts
Scripts used in support of Piwigo

## To get files from my computer to my server
```bash
rsync -rvzhte ssh --progress "/Volumes/DW Untethered/Imagery/6DMII/" username@lebanon.dreamhost.com:/home/username/mysite.com/galleries/ --partial-dir=.rsync-partial
```

Or use a while loop so it keeps trying after network dropouts and verify checksums:
```bash
while ! \
rsync -rvhti --stats --progress --checksum --partial-dir=.rsync-partial "/Volumes/DW Untethered/Imagery/" -e ssh username@lebanon.dreamhost.com:/home/username/mysite.com/galleries/ ; \
do now=$(date +"%T") ; echo · Error at $now · ; sleep 60 ; done
```

### Sync imagery from small HD to dreamhost
```bash
while ! rsync -rvhti --stats --progress --partial-dir=.rsync-partial "/Volumes/DW Untethered/Imagery/" -e ssh username@lebanon.dreamhost.com:/home/username/mysite.com/galleries/ ; \
do now=$(date +"%T") ; echo · Error at $now · ; sleep 60 ; done
```

### Sync source video files from small HD to dreamhost
```bash
while ! rsync -rvhti --stats --progress --partial "/Volumes/DW Untethered/Files/VideoSource/" -e ssh username@lebanon.dreamhost.com:/home/username/mysite.com/VideoSource/ ; \
do now=$(date +"%T") ; echo · Error at $now · ; sleep 60 ; done
```

### Sync files from small HD to big HD
```bash
while ! rsync -rvhti --stats --progress --partial-dir=.rsync-partial "/Volumes/DW Untethered/Files/" "/Volumes/Welsh Imagery/Files/" ; do now=$(date +"%T") ; echo · Error at $now · ; sleep 60 ; done
```

### Sync imagery from small HD to big HD
```bash
while ! rsync -rvhti --stats --progress --partial-dir=.rsync-partial "/Volumes/DW Untethered/Imagery/" "/Volumes/Welsh Imagery/Imagery/" ; do now=$(date +"%T") ; echo · Error at $now · ; sleep 60 ; done
```

### INSTA360 - Sync imagery from Insta360 SD Card "Untitled" to small HD
rsync -rvhti --stats --progress --partial-dir=.rsync-partial "/Volumes/Untitled/DCIM/" "/Volumes/DW Untethered/Imagery/Insta360/" --dry-run

### DSLR -  Sync JPGs from EOS_DIGITAL SD Card "EOS_DIGITAL" to small HD
rsync -rvhti --stats --progress --partial-dir=.rsync-partial "/Volumes/EOS_DIGITAL/DCIM/100CANON/" "/Volumes/DW Untethered/Imagery/6DMII/Images/" --include="*/" --include="*.JPG" --exclude="*" --dry-run

### DSLR -  Sync Raw Images from EOS_DIGITAL SD Card "EOS_DIGITAL" to small HD
rsync -rvhti --stats --progress --partial-dir=.rsync-partial "/Volumes/EOS_DIGITAL/DCIM/100CANON/" "/Volumes/DW Untethered/Imagery/6DMII/Raw Images/" --include="*/" --include="*.CR2" --exclude="*" --dry-run

### DSLR -  Sync Videos from EOS_DIGITAL SD Card "EOS_DIGITAL" to small HD
rsync -rvhti --stats --progress --partial-dir=.rsync-partial "/Volumes/EOS_DIGITAL/DCIM/100CANON/" "/Volumes/DW Untethered/Imagery/6DMII/Videos" --include="*/" --include="*.M*" --exclude="*" --dry-run


## Scripts
### piwigo_refresh.pl
Script originally from https://piwigo.org/ext/extension_view.php?eid=855 but customized for my use. This takes the files from my server directory and imports them into Piwigo (run frequently by cron).

### piwigo_vid_thumbs.pl
Modified copy of the piwigo_refresh.pl script, but using the VideoJS extension interface. This makes screenshot "posters" for video files in Piwigo (run frequently by cron).
