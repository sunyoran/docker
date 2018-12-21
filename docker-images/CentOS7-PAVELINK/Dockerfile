FROM openshift/base-centos7

#RUN INSTALL_PKGS="deltarpm net-tools tar unzip bc which lsof wget vim java-1.8.0-openjdk java-1.8.0-openjdk-devel openssh*" && \
#    yum install -y --enablerepo=centosplus $INSTALL_PKGS && \
#    yum clean all -y

RUN INSTALL_PKGS="tar unzip bc which lsof wget vim java-1.8.0-openjdk java-1.8.0-openjdk-devel openssh*" && \
    yum clean all -y && \
    yum update -y && \
    yum install -y $INSTALL_PKGS && \
    yum clean all -y
