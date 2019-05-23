#!/usr/bin/env nextflow

params.diffrac = '/diffrac/'

params.control_elut = ""
params.experiment_elut = ""
params.annotation_file = ""

params.results_path = "./results"
params.feat_file = 'diffrac.feat'

params.features = "diffrac diffrac_percent pearsonr diffrac_normalized mean_abundance emd zscore sliding_zscore fdr_correct sliding_fdr_correct"

ctrlElutFile = file(params.control_elut)
expElutFile = file(params.experiment_elut)


process runDiffrac {

    publishDir "${params.results_path}"

    input:
    file ctrlElut from ctrlElutFile
    file expElut from expElutFile

    output:
    file "${params.feat_file}" into feat_file
    stdout result

    """
    echo 'running Diffrac';

    python ${params.diffrac}/diffrac.py --elution_files $ctrlElut $expElut  --features ${params.features} --output_file ${params.feat_file} --annotated_list ${params.annotation_file}  --use_gmm 
    """
}

process create_ids_file {

    input:
    file ctrlElut from ctrlElutFile
    file expElut from expElutFile
    
    output:
    val ids_file.readlines() into ids
    stdout result2

    """
    cat $ctrlElut $expElut |cut -f1|sort|uniq > 'ids.txt'
    """
}

process plotSparkline {

    publishDir "${params.results_path}"

    input:
    file ctrlElut from ctrlElutFile
    file expElut from expElutFile
    val id1 from ids
    
    output:
    file '*.pdf' into sparkline_pdf
    stdout result3

    """

    echo "plotSparkline: $id1"

    """
}

result.subscribe {
    println it
}

result2.subscribe {
    println it
}

result3.subscribe {
    println it
}


