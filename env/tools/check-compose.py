#!/usr/bin/env python3
from yaml import safe_load
import sys

# compose.ymlファイルを開き、YAMLの内容を取得します
# その中で、sevices.web.buildキーが存在していたら失敗して終了します(戻り値1)
# 成功時は戻り値0を返してください
def main():
    with open('compose.yml') as f:
        yml = safe_load(f)
        if 'services' in yml and 'web' in yml['services'] and 'build' in yml['services']['web']:
            print("services.web.buildキーが存在します、無効化してから出直してください", file=sys.stderr)
            return 1
    return 0

if __name__ == '__main__':
    sys.exit(main())
