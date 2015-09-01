echo "WARNING, DUPLICATE IMAGE TAGS ARE NOT PUSHED AND DON\'T THROW A BUILD ERROR"
set +e
make -f Makefile-schmunk42 tag

docker login --username="${DOCKERHUB_USER}" --password="${DOCKERHUB_PASS}" --email="noreply@example.com" https://index.docker.io/v1/
make -f Makefile-schmunk42 push