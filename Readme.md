```bash
docker build -t my_jenkins .
docker run -d -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 --net jira --name jenkins --add-host jira.local:172.18.0.1 my_jenkins 
docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

```bash
docker pull atlassian/jira-software
docker volume create --name jiraVolume
docker run -v jiraVolume:/var/atlassian/application-data/jira --name="jira" -d -p 9090:8080 --net jira atlassian/jira-software
```

