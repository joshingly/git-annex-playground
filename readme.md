# Git Annex Playground
* Add to .ssh/config file:

```
Host localtest
  User developer
  Hostname localhost
  Port 2200
  IdentitiesOnly yes
  IdentityFile /Users/josh/Sync/Code/git-annex-playground/localtest
```

* git annex initremote localtest type=rsync rsyncurl=developer@localtest:Crypt/files encryption=hybrid keyid={YOUR KEY HERE} mac=HMACSHA512
* git remote add coordinator gcrypt::rsync://developer@localtest/home/developer/Crypt/repo
* git config remote.coordinator.gcrypt-participants "{YOUR KEY HERE}"
* git clone gcrypt::rsync://developer@localtest/home/developer/Crypt/repo Crypt
* get annex init or reinit NAME
* git remote rename origin coordinator
* git remote enableremote localtest

## Cleanup Procedure
* https://git-annex.branchable.com/forum/safely_dropping_git-annex_history/#comment-241fad95eb2cf5ca2d39993eff717965
* Clear everything in the coordinator repo folder then do the below on the 
  local server. 
* git remote rm coordinator
* gco git-annex
* cp *.log ..
* git rm -r *
* mv ../*.log .
* gaa
* gci -m 'update'
* grb -i --root
  * Squash into the root commit
* Delete synced/git-annex if exists
* gco master
* grb -i --root
  * Squash into the root commit
* If synced/master exists
  * gco synced/master
  * git reset --hard master
* rm .git/annex/index
* git annex fsck --fast --jobs 8
* git annex fsck --fast --from localtest --jobs 8
* git annex sync
* Re-add coordinator, coordinator config, re-initialize (delete & clone)
  cloud server.
