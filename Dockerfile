FROM public.ecr.aws/docker/library/python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
ENV PORT=8082
ENV FLASK_DEBUG=0
EXPOSE 8082
CMD ["python", "app.py"]
