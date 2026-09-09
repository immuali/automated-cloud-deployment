FROM python:3.12-slim AS builder

WORKDIR /build

COPY requirements.txt .

RUN pip install \
    --no-cache-dir \
    --prefix=/install \
    -r requirements.txt


FROM python:3.12-slim AS runtime

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN addgroup --system appgroup \
    && adduser --system --ingroup appgroup appuser

COPY --from=builder /install /usr/local

COPY app ./app

USER appuser

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')"

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app.app:app"]