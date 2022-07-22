FROM fischerscode/flutter-sudo AS build

COPY . .

#RUN flutter doctor
#RUN flutter config --enable-web
RUN flutter pub get
RUN flutter build web /output

FROM python

COPY --from=build /output /

CMD ["python", "-m", "http.server", "$PORT"]
