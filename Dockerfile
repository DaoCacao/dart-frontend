FROM fischerscode/flutter-sudo AS build

COPY . .

#RUN flutter doctor
#RUN flutter config --enable-web
RUN flutter pub get
RUN flutter build web

FROM python

COPY --from=build build/web .

CMD ["python", "-m", "http.server", "$PORT"]
