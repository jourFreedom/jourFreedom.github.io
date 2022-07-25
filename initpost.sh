#! /bin/bash

# 写入文件模板
tempFun() {
  result="---\ntitle: $1\ndate: $2\n$3: $4\ncover: \ntags: \ncategories: \n---"
}

# 处理文件
dealFile() {
  tempFun "$1" "$2" "$3" "$4"
  # echo $tempFun a b c d
  # echo $result >> ./source/_posts/text.txt
  echo $result
  sed -i "1i\\$result" "$5"
}

# 匹配是否存在文件头
# match() {
#   sed d 's/---/replace/' $*
# }

# match ./source/_posts/text.txt


# 写入头部
# 现在一个文件都不能写入

for files in ./source/_posts/*
do
  if test -f $files
  then
    echo $files是文件
  else
    for file in `find $files/* -name "*.md" -o -name "*.txt"`;
    do
      # echo $file
      dealFile "$(basename ${file%.*})" "$(date +%Y-%m-%d' '%H:%M:%S)" "categories" "${files##*/}" "${file}"
    done
  fi
done

echo 按任意键继续
read -n 1
echo 继续运行