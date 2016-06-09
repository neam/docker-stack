tutum login
tutum stack create -n text-to-flowchart-generators -f tutum.yml | tee .tutum-stack
tutum stack update -f tutum.yml $(cat .tutum-stack)
