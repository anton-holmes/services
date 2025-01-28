docker run -d -v .:/app -w /app/doc -p 8000:8000 --restart=unless-stopped minidocks/mkdocs:1-pdf serve -a 0.0.0.0:8000 -t material

cd doc
touch mkdocs.yml
mkdir docs

перемести md документы в docs
