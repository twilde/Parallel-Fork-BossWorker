use 5.008005;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Parallel::Fork::BossWorker',
    VERSION_FROM      => 'lib/Parallel/Fork/BossWorker.pm', # finds $VERSION
    PREREQ_PM         => {
			   Data::Dumper => 0
			 }, # e.g., Module::Name => 1.1
    LICENSE	      => 'perl',
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Parallel/Fork/BossWorker.pm', # retrieve abstract from module
       AUTHOR         => 'Jeff Rodriguez, Tim Wilde') : ()),
    META_MERGE => {
        resources => {
            repository => 'https://github.com/twilde/Parallel-Fork-BossWorker',
        },
    },
);
