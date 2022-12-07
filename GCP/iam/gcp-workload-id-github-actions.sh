repo_name=
org_name=
project_id=

gcloud config set project $project_id

gcloud iam workload-identity-pools create "github-${repo_name}-pool" \
    --location="global" \
    --description="Workload ID pool for Github Actions use with ${repo_name}/${org_name}" \
    --display-name="github-${repo_name}-pool"

gcloud iam workload-identity-pools providers create-oidc "github-${repo_name}-provider" \
    --location="global" \
    --workload-identity-pool="github-${repo_name}-pool" \
    --issuer-uri="https://token.actions.githubusercontent.com" \
    --attribute-mapping="google.subject=assertion.sub,attribute.repository=assertion.repository" \
    --attribute-condition="attribute.repository=='${org_name}/${repo_name}'"

gcloud iam service-accounts create "${repo_name}-github-sa" --display-name="${repo_name} Github Action Service account" --description="For use with Github actions deployments on ${org_name}/${repo_name}"

project_number=`gcloud projects list --filter="${project_id}" --format="value(PROJECT_NUMBER)"`

gcloud iam service-accounts add-iam-policy-binding "${repo_name}-github-sa@${project_id}.iam.gserviceaccount.com" \
    --project="${project_id}" \
    --role="roles/iam.workloadIdentityUser" \
    --member="principalSet://iam.googleapis.com/projects/${project_number}/locations/global/workloadIdentityPools/github-${repo_name}-pool/*"