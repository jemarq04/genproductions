if [[ $# -ne 1 ]]; then
	echo usage: $0 DIRNAME
	exit 1
fi

pushd /afs/hep.wisc.edu/home/marquez5/CMSSW/CMSSW_12_3_0/src/Configuration/GenProduction/bin/MadGraph5_aMCatNLO/out > /dev/null
if [[ -d $1 ]]; then
	echo error: dir:$1 already exists
	exit 1
fi

if [[ ! -d template ]]; then
	echo error: template directory missing
	exit 1
fi

mkdir $1
cp -r template/cards $1/
cp -r template/Utilities $1/
cp template/*.sh $1/
echo "../../gridpack_generation.sh $1 cards local ALL $SCRAM_ARCH CMSSW_12_3_0" > $1/generate_${1}.sh
chmod u+x $1/generate_${1}.sh
echo "$1/" > $1/.gitignore

for file in $1/cards/*.dat; do
	mv $file $1/cards/$1_${file##*/}
done

popd > /dev/null
