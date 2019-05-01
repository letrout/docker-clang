FROM ubuntu:19.04
LABEL maintainer="Joel Luth (joel.luth@gmail.com)"
LABEL description="clang/llvm build environment"

ENV CLANG_VER 8
ENV UBUNTU_VER disco
ENV CC clang-${CLANG_VER}

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		ca-certificates \
		gpg-agent \
		software-properties-common \
		wget \
		xz-utils \
	&& apt-get clean \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
	&& apt-add-repository "deb http://apt.llvm.org/${UBUNTU_VER}/ llvm-toolchain-${UBUNTU_VER}-${CLANG_VER} main" \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		clang-${CLANG_VER} \
	&& apt-get clean \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]	
