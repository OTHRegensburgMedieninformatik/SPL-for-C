pipeline {
    agent any 

    stages {
        stage('Clean') { 
            steps { 
                sh 'make clean'
            }
        }
        stage('Build FreeImage') { 
            steps { 
                sh 'make -j6 freeimage'
            }
        }
        stage('Build Lib') { 
            steps { 
                sh 'make -j6 lib'
            }
        }
        stage('Build Examples') { 
            steps { 
                sh 'make -j6 examples'
            }
        }
        stage('Build Clion') { 
            steps { 
                sh 'make -j6 clion'
            }
        }
        stage('Build Codeblocks') { 
            steps { 
                sh 'make -j6 codeblocks'
            }
        }
        stage('Build Makefile') { 
            steps { 
                sh 'make -j6 mfile'
            }
        }
        stage('Build Starter') { 
            steps { 
                sh 'make -j6 starter'
            }
        }
    }
}
