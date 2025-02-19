pipeline {
    agent any

    environment {
        RENDER_SERVICE_ID = "csn8pkdds78s7391dpsg"  // Replace with your actual Render Service ID
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/anshsehgal13/Portfolio.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    if (fileExists('package.json')) {
                        sh 'npm install'
                    } else {
                        echo 'No package.json found, skipping dependencies installation.'
                    }
                }
            }
        }

        stage('Build App') {
            steps {
                script {
                    if (fileExists('package.json')) {
                        sh 'npm run build'
                    } else {
                        echo 'No build step required for static site.'
                    }
                }
            }
        }

        stage('Deploy to Render') {
            steps {
                script {
                    sh '''
                    curl -X POST "https://api.render.com/deploy/srv-${RENDER_SERVICE_ID}?key=rnd_qXmPDBgzdjGTrvsQRnZcqoz8Z22k"
                    '''
                }
            }
        }
    }
}
