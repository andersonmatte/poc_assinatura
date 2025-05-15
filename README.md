# PoC Assinatura

# Flutter Signature Screen

Este projeto é um exemplo básico de como utilizar a biblioteca [`signature`](https://pub.dev/packages/signature) no Flutter para capturar assinaturas digitais.

---

## Funcionalidade

A biblioteca `signature` permite criar uma área interativa onde o usuário pode desenhar sua assinatura usando o dedo ou a caneta. O app permite:

- Desenhar a assinatura numa área dedicada.
- Limpar o quadro de assinatura.
- Salvar a assinatura como imagem PNG e visualizar em um diálogo.
- Área de desenho com fundo customizável e configuração do traço.

---

## Tela de Assinatura

- O usuário vê um quadro para assinar (50% da altura da tela).
- Dois botões: **Limpar** para apagar o desenho e **Salvar** para exportar a assinatura.
- Ao salvar, aparece um diálogo com a imagem da assinatura, e um botão "X" para fechar.
- Layout responsivo que se adapta a diferentes tamanhos e orientações de tela.

---

## Como usar

1. Adicione a dependência no seu `pubspec.yaml`:

```yaml
dependencies:
  signature: ^6.0.0

![alt text](https://github.com/andersonmatte/poc_assinatura/blob/master/assets/prints/print1.png)
![alt text](https://github.com/andersonmatte/poc_assinatura/blob/master/assets/prints/print2.png)
![alt text](https://github.com/andersonmatte/poc_assinatura/blob/master/assets/prints/print3.png)