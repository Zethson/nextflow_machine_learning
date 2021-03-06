process train_mnist_pytorch {
    echo true
    container 'mlflowcore/pytorch:dev'
    
    if (params.platform == 'all_gpu') {
        label 'with_all_gpus'
    } else if (params.platform == 'single_gpu') {
        label 'with_single_gpu'
    } else {
        label 'with_cpus'
    }   


    when: params.pytorch

    script:
    """
    train_mnist_pytorch.py --epochs ${params.epochs} --seed ${params.seed}
    """
}

process train_mnist_tensorflow {
    echo true
    container 'mlflowcore/tensorflow:dev'

    if (params.platform == 'all_gpu') {
        label 'with_all_gpus'
    } else if (params.platform == 'single_gpu') {
        label 'with_single_gpu'
    } else {
        label 'with_cpus'
    }  

    when: params.tensorflow

    script:
    """
    train_mnist_tensorflow.py --epochs ${params.epochs}
    """
}

process train_boston_covtype_xgboost {
    echo true
    container 'mlflowcore/xgboost:dev'

    if (params.platform == 'all_gpu') {
        label 'with_all_gpus'
    } else if (params.platform == 'single_gpu') {
        label 'with_single_gpu'
    } else {
        label 'with_cpus'
    } 

    when: params.xgboost && (params.platform == 'single_gpu' || params.platform == 'cpu')

    script:
    """
    train_boston_covtype_xgboost.py --epochs ${params.epochs} --dataset ${params.dataset} --no-cuda ${params.no_cuda} --seed ${params.seed}
    """
}

process train_boston_covtype_dask_xgboost {
    echo true
    container 'mlflowcore/xgboost:dev'

    if (params.platform == 'all_gpu') {
        label 'with_all_gpus'
    } else if (params.platform == 'single_gpu') {
        label 'with_single_gpu'
    } else {
        label 'with_cpus'
    } 

    when: params.xgboost && params.dask

    script:
    """
    train_boston_covtype_dask_xgboost.py --epochs ${params.epochs} --dataset ${params.dataset} --n-gpus ${params.n_gpus} --seed ${params.seed}
    """
}
