FROM fischerscode/flutter AS build

COPY . .
RUN flutter doctor
RUN flutter config --enable-web
RUN flutter pub get
RUN flutter build web -o /build

FROM python

COPY --from=build /build/web /

CMD ["python", "-m", "http.server", "$PORT"]
