FROM fischerscode/flutter AS build

USER root
WORKDIR /app/
COPY . .

#RUN flutter doctor
#RUN flutter upgrade
#RUN flutter config --enable-web
RUN flutter build web

FROM python

COPY --from=build /app/build/web .

CMD python -m http.server $PORT
