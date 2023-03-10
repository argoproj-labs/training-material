echo
echo "Starting setup..."
echo
git clone https://github.com/argoproj/argo-workflows.git --depth 1 -q
mv argo-workflows/examples/ . > /dev/null
rm -rf argo-workflows > /dev/null

curl -s https://raw.githubusercontent.com/pipekit/argo-workflows-intro-course/master/argo-workflows/install.sh|sh
