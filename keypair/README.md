# KeyPair

현재 디렉토리는 KeyPair에 관한 내용을 담고 있습니다.

해당 디렉토리에 있는 테라폼 코드를 실행하면, EC2 인스턴스에 접근하기 위한 KeyPair를 생성합니다.

## 구성 요소

- `main.tf`: KeyPair 리소스를 생성하는 테라폼 코드가 작성되어 있습니다.
- `outputs.tf`: 테라폼 실행 후 생성된 리소스의 정보를 출력하는 파일입니다.

## 사전 준비 사항

- AWS CLI 설치 및 계정 설정 (`aws configure`)
- 테라폼 설치

## 시작하기

1. `terraform init` 명령어를 실행하여 테라폼을 초기화합니다.

    ```bash
    terraform init
    ```
2. `terraform plan` 명령어를 실행하여 실행 계획을 확인합니다.

    ```bash
    terraform plan
    ```

3. `terraform apply` 명령어를 실행하여 리소스를 생성합니다.

    ```bash
    terraform apply
    ```

## 정리하기

1. `terraform destroy` 명령어를 실행하여 생성한 리소스를 삭제합니다.

    ```bash
    terraform destroy
    ```