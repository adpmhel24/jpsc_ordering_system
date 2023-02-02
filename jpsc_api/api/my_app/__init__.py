from google.cloud import storage
from my_app.core.settings.config import settings

# Cloud Storage.
gcp_storage = storage.Client()
gcp_bucket_name = settings.CLOUD_STORAGE_BUCKET
