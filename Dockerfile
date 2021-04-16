ARG PLATFORM
ARG ROS_DIST
#FROM --platform=linux/$PLATFORM ros:$ROS_DIST-ros-core-stretch
FROM --platform=linux/$PLATFORM node:10

ARG ROS_DIST

#COPY ./entry.sh /entry.sh
CMD npm run serve-static-webviz

RUN	git clone https://github.com/cruise-automation/webviz.git && \
        cd webviz && \
	npm run bootstrap && \
	npm run build-static-webviz
