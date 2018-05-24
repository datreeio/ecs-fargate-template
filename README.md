# webservicetemplate [![JavaScript Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://standardjs.com) [![Greenkeeper badge](https://badges.greenkeeper.io/datreeio/ecs-fargate-template.svg)](https://greenkeeper.io/)

Web Service Template

## Instructions

1.  Rename the cloned dir to your service name
1.  Coveralls
    * Enable in coveralls.io and add the repo token to .coveralls.yml
1.  update `.git/config` with you repo details
1.  delete `GIT_PLACEHOLDER_DELETE` it's there only to create the `lib` directory
1.  ECS/ECR
    * Create a registry with the service name
    * Create a task definision in ECS us-east-1 (N.Virginia) region - with the service name
1.  Travis

    * Enable the repo in travis
    * DO NOT USE YOU YOUR OWN KEYS
    * `travis encrypt AWS_ACCESS_KEY_ID=<AWS_ACCESS_KEY_ID> --add`
    * `travis encrypt AWS_SECRET_ACCESS_KEY=<AWS_SECRET_ACCESS_KEY> --add`
    * `travis encrypt GH_TOKEN=<GH_TOKEN> --add`
    * `travis encrypt NPM_TOKEN=<NPM_TOKEN> --add`

1.  find and replace all occurences of [**webservicetemplate**](https://github.com/datreeio/webservicetemplate/search?q=webservicetemplate&projid=github.com%2Fdatreeio%2Fwebservicetemplate&searchType=code) with your service name.
1.  Update README.md
1.  Update `package.json` with the service name

# Secrets Configuration - SSM + KMS

1.  Create a KMS encryption key with the service name
1.  Create a secret parameter with the KMS key with the service name as an alias
1.  `config/configuration.js` pulls the secrets and decrypts them before `npm start` and `npm test`
