
# How to fork the project and build the feed and image for yourself

1. fork all branches of repo: `packages` `releases`

   usign is available as source code at https://github.com/openwrt/usign or as executable code in the .hosts/x86_64/bin directory
2. exec `gen_new_usign_key.sh` generate usign key for yourself
   + `./keys/usign/*.pub`    Public usign key
   + `./keys/usign/*.sec`    Secret usign key (do not push this file. It is a secret)

3. exec `gen_new_gpg_key.sh` generate gpg key for yourself
   + `./keys/gpg/*.finger`
   + `./keys/gpg/*.pub`
   + `./keys/gpg/*.rev`      revocation certificate.
   + `./keys/gpg/*.sec`      Secret gpg key (do not push this file. It is a secret)
   + `./keys/gpg/*.pw `      Secret gpg key (do not push this file. It is a secret)

4. You could save the secret usign and gpg files in github action secrets but then they are no longer viewable.
   If you would like to see the plaintext again then you can install git-secret from https://github.com/sobolevn/git-secret.git.
   Documentation at https://sobolevn.me/git-secret/

   run "git secret init" to create .secret folder and initial git repository
   a) Add the first user to the git-secret repo keyring by running git secret tell your@email.id.
   b) git secret add keys/usign/*.sec
   c) git secret add keys/gpg/*.sec
   d) git secret add keys/gpg/*.pw
   e) git secret hide     #use to hide the files
   f) add and commit the changes.
   g) later use git secret reveal   # use to reveal the secrets

If you are debugging with ACT. (https://github.com/nektos/act)  then execute steps 6 and 7.
If you are running on github with actions the execute 3 and 4 then skip to step 8

4) goto `https://github.com/<your_fork>/settings/secrets/actions`, add your secret keys
   + GPG_<your_gpg_key-id>: "contents of your_gpg.sec file"
   + GPG_PW_<your_gpg_key-id>: "contents of your_gpg.pw file"
   + USIGN_<your_usign_key-id>: "contents of your usign.sec file"

5) goto `https://github.com/<your_fork>/settings/variables/actions`, add your public keys
   + GPG_ID : <your_gpg_key-id>
   + GPG_PUB_<your_gpg_key-id> : "contents of your gpg.pub file"
   + GPG_FING_<your_gpg_key-id> : "contents of your gpg.finger file"
   + USIGN_ID: <your_usign_key-id>
   + USIGN_PUB_<your_usign_key-id> : "contents of your usign.pub file"
   + VERIFY_KEY_ID : 53FF2B6672243D28
skip to step 8

6) Create file ./.secret
   + GPG_<your_gpg_key-id>="contents of your_gpg.sec file"
   + GPG_PW_<your_gpg_key-id>="contents of your_gpg.pw file"
   + USIGN_<your_usign_key-id>="contents of your usign.sec file"
   + GITHUB_TOKEN

7) Create file ./.variables and add the following lines
   +  ACTIONS_STEP_DEBUG='true' or ='false'           #ACT command to increase debug logging.
   +  GPG_ID="<your_gpg_key-id>"
   +  GPG_PUB_<your_gpg_key-id>="contents of your gpg.pub file"
   +  GPG_FING_<your_gpg_key-id>="contents of your gpg.finger file"
   +  USIGN_ID`: <your_usign_key-id>
   +  USIGN_PUB_<your_usign_key-id>="contents of your usign.pub file"
   + `VERIFY_KEY_ID`: 53FF2B6672243D28


5. if you need to use other external feeds to build a image, you need to put their usign pub-keys in the specified location and add them to the `VERIFY_KEY_ID`
   + `./keys/usign/<external_feeds_usign_key-id>.pub`
   + `VERIFY_KEY_ID`: "53FF2B6672243D28 <the_usign_key-ids,_with_spaces_as_separators>"
6. modify [ version, arch, target, profile, no_img ] matrix to replace the target devices
   + edit [AutoBuild.yml](./.github/workflows/AutoBuild.yml)
   + modify the values ​​in `jobs:compile:strategy:matrix` according to the actual situation
   + available `target, arch` can refer to [targets.txt](./targets.txt)
   + available `profile` can refer to `https://downloads.openwrt.org/releases/<version>/targets/<target[0]>/<target[1]>/config.buildinfo`

7. adjust the imagebuilder preinstalled packages
   + modify [./.github/workflows/prebuildpackages/generic](./.github/workflows/prebuildpackages/generic)
   + modify `./.github/workflows/prebuildpackages/<arch>`
