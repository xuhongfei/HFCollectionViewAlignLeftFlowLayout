# HFCollectionViewAlignLeftFlowLayout

`HFCollectionViewAlignLeftFlowLayout`继承自`UICollectionViewFlowLayout`，用于实现Cells左对齐。采用swift实现，支持最新swift5。

<img src="https://github.com/xuhongfei/HFCollectionViewAlignLeftFlowLayout/blob/master/example.jpg" width="423" height="838" alt="example图片加载失败"/>

# 使用方法
正如你使用`UICollectionViewFlowLayout`一样，使用`HFCollectionViewAlignLeftFlowLayout`来替代`UICollectionViewFlowLayout`即可:
```
let frame = CGRect.zero
let layout = HFCollectionViewAlignLeftFlowLayout()
let alignLeftCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
```
# License
`HFCollectionViewAlignLeftFlowLayout` is released under the [MIT license](https://github.com/xuhongfei/HFCollectionViewAlignLeftFlowLayout/blob/master/LICENSE).

***
@xuhongfei
