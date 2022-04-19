
#!/bin/sh
version=$(git describe --abbrev=0)
img="dev-debian:"${version}
docker build -t ${img} .

