# README
This Project runs rails app with postgres,redis and sidekiq using kubernetes.

## Prerequisites
1. minikube on machine
2. docker on machine

## Setup
### Rails App setup
1. Created a rails app using `rails new <APP_NAME>`
2. Added these changes in `Gemfile` and removed `sqlite`

```
gem 'unicorn'
gem 'pg'
gem 'sidekiq'
gem 'redis-rails'
```

3. Added changes in `config/database.yml` as shown [here](https://github.com/3mRoshdy/k8s-rails-app/blob/master/config/database.yml).
4. Added changes in `config/secrets.yml` as shown [here](https://github.com/3mRoshdy/k8s-rails-app/blob/master/config/secrets.yml).
5. Added changes in `config/application.rb` as shown [here](https://github.com/3mRoshdy/k8s-rails-app/blob/master/config/application.rb).
6. Created config file `config/unicorn.rb` as shown [here](https://github.com/3mRoshdy/k8s-rails-app/blob/master/config/unicorn.rb).
7. Created config file `config/initializers/sidekiq.rb` as shown [here](https://github.com/3mRoshdy/k8s-rails-app/blob/master/config/initializers/sidekiq.rb).
8. Created Dockerfile as shown [here](https://github.com/3mRoshdy/k8s-rails-app/blob/master/Dockerfile).
9. Created `.dockerignore` file.

### Kubernetes Setup
File related for each structure
```
- postgres:
  - postgres-configmap.yml
  - postgres-volume.yml
  - postgres-service.yml
  - postgres-deployment.yml

- app:
  - app-config.yml
  - app-setup-job.yml
  - app-service.yml
  - app-deployment.yml

- redis:
  - redis-volume.yml
  - redis-service.yml
  - redis-deployment.yml

- sidekiq:
  - sidekiq-service.yml
  - sidekiq-deployment.yml
```

### Running the app:
To run the app using kubernetes:
1. make sure minikube is up.
2. you need to build the docker image locally on minikube since it is not pushed on docker hub using `eval $(minikube docker-env)`.

Note: after this you can make sure that you are now looking on minikube docker images using `docker image ls` and find images starting with `k8s.gcr.io/`.

3. build docker image using `docker image build -t roshdy/k8s-rails-app .` (DON'T Change image name).

4. create postgres configmap using `kubectl create -f k8s/postgres-configmap.yml`
5. create postgres volume using  `kubectl create -f k8s/postgres-volume.yml`
6. create postgres service using  `kubectl create -f k8s/postgres-service.yml`
7. create postgres deployment using  `kubectl create -f k8s/postgres-deployment.yml`

8. create redis volume using  `kubectl create -f k8s/redis-volume.yml`
9. create redis service using  `kubectl create -f k8s/redis-service.yml`
10. create redis deployment using  `kubectl create -f k8s/redis-deployment.yml`

11. create rails app configmap using  `kubectl create -f k8s/app-config.yml`
12. create rails app job using `kubectl create -f k8s/app-setup-job.yml`
13. create rails app service using `kubectl create -f k8s/app-service.yml`
14. create rails app deployment using `kubectl create -f k8s/app-deployment.yml`

15. create sidekiq service using  `kubectl create -f k8s/sidekiq-service.yml`
16. create sidekiq deployment using  `kubectl create -f k8s/sidekiq-deployment.yml`

17. run `kubectl get svc -o wide` to get the service name for the rails app.
18. run `minikube service rails-app --url` to get the remote url.
19. open the url in your browser you should see the rails app running.
20. you can navigate to `/posts` in the url to see the database changes.
