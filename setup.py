import setuptools

VERSION = (1, 1, 0)
__version__ = '.'.join([str(i) for i in VERSION])
__url__ = 'https://github.com/leonardolch/postcode_uk.git'

install_requires = [
]

setuptools.setup(
    name="postcode_uk",
    version=__version__,
    url=__url__,
    packages=setuptools.find_packages(),
    excludes=['tests'],
    install_requires=install_requires,
    classifiers=[
        "Programming Language :: Python :: 3",
    ],
)
