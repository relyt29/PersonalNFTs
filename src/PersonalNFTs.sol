// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.10;

import "./Ownable.sol";
import "./Solmate1155.sol";

contract PersonalNFTs is ERC1155, Ownable {

    string contractMetadataURI;
    string defaultMetadataURI;
    mapping (uint256 => string) uriStrings;
    uint public collectionArtPiecesCount = 0;

    constructor(string memory _contractMetadataURI, string memory _defaultMetadataURI) {
        contractMetadataURI = _contractMetadataURI;
        defaultMetadataURI = _defaultMetadataURI;
    }

    function changeContractURI(string calldata _s) external onlyOwner {
        contractMetadataURI = _s;
    }

    function contractURI() external view returns (string memory) {
        return contractMetadataURI;
    }

    function changeDefaultMetadataURI(string calldata _s) external onlyOwner {
        for (uint i = 0; i < collectionArtPiecesCount; i++) {
            if(bytes(uriStrings[i]).length == 0)
                emit URI(_s, i);
        }
        defaultMetadataURI = _s;
    }

    function changeURI(string calldata _s, uint _id) external onlyOwner {
        uriStrings[_id] = _s;
        emit URI(_s, _id);
    }

    function uri(uint256 id) public view override returns (string memory) {
        if(bytes(uriStrings[id]).length != 0)
            return uriStrings[id];
        return defaultMetadataURI;
    }

    function createNewArtPiece(address to, uint256 amount, string calldata _tokenURI) external onlyOwner {
        _mint(to, collectionArtPiecesCount, amount, "");
        if (bytes(_tokenURI).length == 0)
            emit URI(defaultMetadataURI, collectionArtPiecesCount);
        else {
            uriStrings[collectionArtPiecesCount] = _tokenURI;
            emit URI(_tokenURI, collectionArtPiecesCount);
        }
        collectionArtPiecesCount += 1;
    }

    function mintMorePrintsToExistingArtPiece(address to, uint256 id, uint256 amount) external onlyOwner {
        _mint(to, id, amount, "");
    }

    function batchMintMorePrintsToExistingArtPieces(address to, uint256[] calldata ids, uint256[] calldata amounts) external onlyOwner {
        _batchMint(to, ids, amounts, "");
    }

}
