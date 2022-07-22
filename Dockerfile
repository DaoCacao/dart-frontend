FROM fischerscode/flutter AS build

USER root
WORKDIR /app/
COPY . .

#RUN flutter doctor
#RUN flutter upgrade
#RUN flutter config --enable-web
RUN flutter build web

FROM nginx

COPY --from=build /app/build/web /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
