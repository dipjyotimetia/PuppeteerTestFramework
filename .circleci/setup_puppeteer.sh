version: 2
jobs:
  build:
    docker:
      - image: circleci/node:7.10      

    working_directory: ~/repo

    steps:
      - checkout

      # Download and cache dependencies
      - restore_cache:
          keys:
          - v1-dependencies-{{ checksum "package.json" }}
          # fallback to using the latest cache if no exact match is found
          - v1-dependencies-

      - run:
          name: Workaround for GoogleChrome/puppeteer#290
          command: 'sh .circleci/setup_puppeteer.sh'

      - run: yarn install

      - save_cache:
          paths:
            - node_modules
          key: v1-dependencies-{{ checksum "package.json" }}
        
      - run: yarn test