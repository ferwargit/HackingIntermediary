// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

interface IHacking2024 {
    function retrieve() external payable;
    function retrieve2() external payable;
    function mint(address to) external;
    function gradeMe(string calldata name) external;
    function counter(address) external view returns (uint256);
    function foo(address) external view returns (uint8);
    function balanceOf(address) external view returns (uint256);
}

interface IERC721Receiver {
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}

contract HackingIntermediary is IERC721Receiver {
    IHacking2024 public immutable graderContract;

    constructor(address _graderAddress) payable {
        graderContract = IHacking2024(_graderAddress);
    }

    // Implementación de IERC721Receiver con parámetros comentados
    function onERC721Received(
        address /*operator*/,
        address /*from*/,
        uint256 /*tokenId*/,
        bytes calldata /*data*/
    ) external pure returns (bytes4) {
        return IERC721Receiver.onERC721Received.selector;
    }

    // Funciones de verificación
    function checkStatus()
        external
        view
        returns (uint256 counter, uint8 fooValue, uint256 nftBalance)
    {
        counter = graderContract.counter(address(this));
        fooValue = graderContract.foo(msg.sender);
        nftBalance = graderContract.balanceOf(address(this));
    }

    // Step 1: Solo retrieve2
    function step1() external payable {
        graderContract.retrieve2{value: 4}();
    }

    // Step 2: Solo retrieve
    function step2() external payable {
        graderContract.retrieve{value: 4}();
    }

    // Step 3: Mint
    function step3() external {
        graderContract.mint(address(this));
    }

    // Step 4: Grade
    function step4(string calldata name) external {
        graderContract.gradeMe(name);
    }

    receive() external payable {}
}
