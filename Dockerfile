FROM fischerscode/flutter AS build

WORKDIR /app

COPY . /app
#RUN flutter doctor
#RUN flutter config --enaable-web
RUN flutter pub get
RUN flutter build web

FROM python

COPY --from=build /app/build/web /app

CMD ["python", "-m", "http.server", "$PORT"]
