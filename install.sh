echo
echo "Starting rails templates installation in ~/.rails_tempaltes..."

git clone git@github.com:lucascaton/rails_templates.git ~/.rails_templates
echo "alias rails_new='_(){ rails new \$1 --skip-bundle --skip-test-unit -f postgresql -m ~/.rails_templates/default.rb; }; _'" >> ~/.bash_profile

echo "Done!"
