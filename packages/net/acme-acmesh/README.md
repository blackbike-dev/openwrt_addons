This is version 3.1.1 of https://github.com/acmesh-official/acme.sh.git which changes

Rather than do a fetch of the tar file and patches I decided to use git subtree. The command is
git subtree add --prefix=packages/net/acme-acmesh/src https://github.com/acmesh-official/acme.sh.git 3.1.1 --squash

Examples of using git subtree are available at https://craftquest.io/guides/git/git-workflow-tools/git-subtrees
