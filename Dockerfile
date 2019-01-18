FROM ubuntu:18.04

RUN apt-get -qq update && apt-get install --no-install-recommends -y apt-transport-https  software-properties-common && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get -qq update && \
    apt-get -qq install ansible git python-virtualenv && \
    apt-get -qq update && \
    apt-get install make && \
#    apt-get purge -y software-properties-common && \
    mkdir /tmp/ansible
WORKDIR /tmp/ansible
COPY . .
RUN ansible-playbook -i localhost, playbook_localhost.yml && chown -R galaxy:galaxy /galaxy

EXPOSE 80
WORKDIR /galaxy/server

# client build tools; TODO: optimize; requests module; six module(maybe)
RUN apt-get update && apt-get install -y nodejs npm
RUN npm install -g yarn
# build the client
RUN make client-production
# TODO: cleanup: remove build tools we don't need

# TODO: pre-build conda. Check the rest.

# USER galaxy
