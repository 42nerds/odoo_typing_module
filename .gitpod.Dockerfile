#FROM gitpod/workspace-postgres
                    
#USER gitpod

#RUN wget -O - https://nightly.odoo.com/odoo.key | sudo apt-key add - && \
#    echo "deb http://nightly.odoo.com/13.0/nightly/deb/ ./" | sudo tee -a /etc/apt/sources.list.d/odoo.list > /dev/null && \
#    sudo apt-get update && \
#    sudo apt-get install -y odoo

FROM gitpod/workspace-postgres
                    
USER gitpod

RUN sudo apt-get update && \
    sudo apt-get install -yq git gcc libxml2-dev libxslt1-dev \
                             libldap2-dev libsasl2-dev xfonts-75dpi \
                             xfonts-base
 
RUN git clone -b 13.0 --depth 1 https://github.com/odoo/odoo.git \
              /home/gitpod/.pyenv/versions/$(python --version | awk '{print $2}')/lib/python3.8/site-packages/odoo

RUN pip install -r /home/gitpod/.pyenv/versions/$(python --version | awk '{print $2}')/lib/python3.8/site-packages/odoo/requirements.txt && \
    pip install inotify && \
    ## add here more python packages if you need it in odoo
    # pip install --upgrade google-cloud-storage && \
    brew install ripgrep

ENV PATH="/home/gitpod/.pyenv/versions/3.8.3/lib/python3.8/site-packages/odoo:${PATH}"
