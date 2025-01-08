#!/bin/bash

# Проверка аргументов
if [ "$1" != "connect" ] && [ "$1" != "disconnect" ]; then
  echo "Использование: $0 <connect|disconnect> [путь_к_конфигурации]"
  exit 1
fi

ACTION=$1
CONFIG=$2

# Функция для отключения всех активных VPN
disconnect_all_vpn() {
  echo "Отключение всех VPN..."

  # Отключение всех активных WireGuard интерфейсов
  WG_INTERFACES=$(wg show interfaces)
  if [ -n "$WG_INTERFACES" ]; then
    for iface in $WG_INTERFACES; do
      echo "Отключение WireGuard интерфейса: $iface"
      sudo wg-quick down "$iface"
    done
  else
    echo "WireGuard интерфейсы не найдены."
  fi

  # Завершение всех OpenVPN процессов
  OPENVPN_PIDS=$(ps aux | grep "[o]penvpn --config" | awk '{print $2}')
  if [ -n "$OPENVPN_PIDS" ]; then
    echo "Отключение всех OpenVPN процессов..."
    for pid in $OPENVPN_PIDS; do
      sudo kill "$pid"
      echo "OpenVPN процесс $pid завершен."
    done
  else
    echo "OpenVPN процессы не найдены."
  fi

  echo "Все VPN отключены."
}

# Определение типа VPN (WireGuard или OpenVPN)
if [ -n "$CONFIG" ] && [ -f "$CONFIG" ]; then
  if grep -q "\[Interface\]" "$CONFIG"; then
    VPN_TYPE="wireguard"
  elif grep -q "client" "$CONFIG"; then
    VPN_TYPE="openvpn"
  else
    echo "[Ошибка] Не удалось определить тип VPN (WireGuard или OpenVPN)."
    exit 1
  fi
fi

# Выполнение действия
case $ACTION in
  connect)
    if [ -z "$CONFIG" ]; then
      echo "[Ошибка] Для подключения необходимо указать путь к конфигурации."
      exit 1
    fi

    if [ "$VPN_TYPE" = "wireguard" ]; then
      echo "Подключение к WireGuard VPN..."
      sudo wg-quick up "$CONFIG"
      echo "WireGuard VPN подключен."
    elif [ "$VPN_TYPE" = "openvpn" ]; then
      echo "Подключение к OpenVPN..."
      sudo openvpn --config "$CONFIG" --daemon
      echo "OpenVPN подключен."
    fi
    ;;
  disconnect)
    if [ -z "$CONFIG" ]; then
      # Если путь не указан, отключаем все VPN
      disconnect_all_vpn
    else
      # Если путь указан, отключаем конкретный VPN
      if [ "$VPN_TYPE" = "wireguard" ]; then
        echo "Отключение от WireGuard VPN..."
        sudo wg-quick down "$CONFIG"
      elif [ "$VPN_TYPE" = "openvpn" ]; then
        echo "Отключение от OpenVPN..."
        PID=$(ps aux | grep "openvpn --config $CONFIG" | grep -v grep | awk '{print $2}')
        if [ -n "$PID" ]; then
          sudo kill "$PID"
          echo "OpenVPN отключен."
        else
          echo "OpenVPN не найден. Возможно, он уже отключен."
        fi
      fi
    fi
    ;;
  *)
    echo "Неверное действие: $ACTION. Используйте 'connect' или 'disconnect'."
    exit 1
    ;;
esac
