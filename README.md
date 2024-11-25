# Torque ハンズオン
- [Torque ハンズオン](#torque-ハンズオン)
  - [事前準備](#事前準備)
    - [GitHub設定](#github設定)
    - [AWS設定](#aws設定)
    - [Torqueアカウント登録](#torqueアカウント登録)
    - [各種設定控え](#各種設定控え)
  - [ハンズオン](#ハンズオン)
  - [宿題（Web3層デモ）](#宿題web3層デモ)
    - [ゴールイメージ](#ゴールイメージ)
    - [ヒント１](#ヒント１)
    - [ヒント２](#ヒント２)



## 事前準備
### GitHub設定
https://github.com/adoc-github/torque-hands-on
1. 自分のGitHubアカウントでログイン
2. ハンズオン用リポジトリをフォーク
3. Torqueからリポジトリにアクセスするためのアクセスキーを作成
- Personal access token
  <br>Token name: ```torque-hands-on-repo```
  <br>Token value: ```github_***_***``` ※これは自動生成

### AWS設定
1. Torqueに必要なAWSリソースを作成
   
|                 |サービス|リソース|設定項目|設定値|
|:----------------|:-----:|:-------------:|:---------:|:--:|
|<ul><li>[ ] </ul>|IAM    |User           |ユーザー名   |torque-hands-on|
|<ul><li>[ ] </ul>|-      |-              |許可ポリシー|AdministratorAccess|
|<ul><li>[ ] </ul>|-      |-              |アクセスキー|[作成]|
|<ul><li>[ ] </ul>|-      |Policy         |サービス   |Cost Explorer Service|
|<ul><li>[ ] </ul>|-      |-              |アクション許可   |GetCostAndUsage|
|<ul><li>[ ] </ul>|-      |-              |ポリシー名   |torque-cost-policy|
|<ul><li>[ ] </ul>|-      |Role           |信頼されたエンティティタイプ   |AWS アカウント|
|<ul><li>[ ] </ul>|-      |-              |別の AWS アカウント   |349148204654|
|<ul><li>[ ] </ul>|-      |-              |外部 ID を要求する   |adoc-torque-cost-ext-id|
|<ul><li>[ ] </ul>|-      |-              |ロール名   |torque-cost-role|
|<ul><li>[ ] </ul>|VPC    |VPC            |CIDR|10.0.0.0/24|
|<ul><li>[ ] </ul>|-      |Subnet         |CIDR|10.0.0.0/24|
|<ul><li>[ ] </ul>|-      |InternetGateway|VPCアタッチ|Default VPC|
|<ul><li>[ ] </ul>|EC2    |Instance       |インスタンス名|torque-hands-on-agent|
|<ul><li>[ ] </ul>|-      |-              |AMI|Amazon Linux 2 AMI (HVM)|
|<ul><li>[ ] </ul>|-      |-              |インスタンスタイプ|t3a.large|
|<ul><li>[ ] </ul>|-      |-              |ストレージ|100GiB gp2|

2. インスタンスにminikubeをインストール
<details>
<summary>minikubeインストール</summary>

  ```
  #!/bin/bash

  curl -LO "https://dl.k8s.io/release/$(curl -LS https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x ./kubectl
  mv ./kubectl /usr/local/bin/kubectl

  yum update -y
  amazon-linux-extras install -y docker
  systemctl enable docker
  systemctl start docker
  curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  chmod +x minikube
  mv minikube /usr/bin/

  yum install -y conntrack
  VERSION="v1.29.0"
  wget https://github.com/kubernetes-sigs/cri-tools/releases/download/$VERSION/crictl-$VERSION-linux-amd64.tar.gz
  tar zxvf crictl-$VERSION-linux-amd64.tar.gz -C /usr/local/bin
  rm -f crictl-v1.29.0-linux-amd64.tar.gz

  yum install -y golang
  git clone https://github.com/Mirantis/cri-dockerd.git
  cd cri-dockerd/
  mkdir bin
  go build -o bin/cri-dockerd
  mkdir -p /usr/local/bin
  install -o root -g root -m 0755 bin/cri-dockerd /usr/local/bin/cri-dockerd
  cp -a packaging/systemd/* /etc/systemd/system
  sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service
  systemctl daemon-reload
  systemctl enable cri-docker.service
  systemctl enable --now cri-docker.socket

  cd
  CNI_PLUGIN_VERSION="v1.4.0"
  CNI_PLUGIN_TAR="cni-plugins-linux-amd64-$CNI_PLUGIN_VERSION.tgz"
  CNI_PLUGIN_INSTALL_DIR="/opt/cni/bin"
  curl -LO "https://github.com/containernetworking/plugins/releases/download/$CNI_PLUGIN_VERSION/$CNI_PLUGIN_TAR"
  mkdir -p "$CNI_PLUGIN_INSTALL_DIR"
  tar -xf "$CNI_PLUGIN_TAR" -C "$CNI_PLUGIN_INSTALL_DIR"
  rm -f "$CNI_PLUGIN_TAR"
  minikube start --driver=none
  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
  ```

</details>

### Torqueアカウント登録
https://www.quali.com/torque/

### 各種設定控え
|プラットフォーム|設定項目|設定値|
|:--:|:--:|:--:|
|GitHub|アクセストークン|***|
|AWS|ロール外部ID|***|
|AWS|ロールARN|***|
|AWS|ユーザーアクセスキー|***|
|AWS|ユーザーシークレットキー|***|
|Torque|ユーザー名|***|
|Torque|パスワード|***|


## ハンズオン
1. スペース作成
3. エージェント登録
4. 各種認証情報の登録
5. IaCリポジトリ登録
6. コストダッシュボード設定
7. Blueprint作成
8. Blueprintをもとに環境構築
9. 構築環境へアクセス
2. ユーザ登録(山本をスペースアドミン追加)


## 宿題（Web3層デモ）
### ゴールイメージ
![ゴールイメージ1](./readme-src/goal1.png)
### ヒント１
<details>
<summary>開く</summary>

Blueprintに同じIaCモジュールを2つ以上追加することも可能です。

</details>

### ヒント２
<details>
<summary>開く</summary>

今回用意したIaCモジュールはすべて使います。

</details>

