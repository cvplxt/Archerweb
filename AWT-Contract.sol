// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data.
 */
abstract contract Context {
    /**
     * @dev Returns the value of the msg.sender variable.
     */
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    /**
     * @dev Returns the value of the msg.data variable.
     */
    function _msgData() internal view virtual returns (bytes calldata) {
        this;
        return msg.data;
    }
}

/**
 * @dev The IBEP20 standards
 */
interface IBEP20 {
    /**
    * @dev Returns the amount of tokens in existence.
    */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the token decimals.
     */
    function decimals() external view returns (uint8);

    /**
     * @dev Returns the token symbol.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the token name.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the bep token owner.
     */
    function getOwner() external view returns (address);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering.
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 */
abstract contract Ownable is Context {
    // Current owner address
    address private _owner;
    // Previous owner address
    address private _previousOwner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the given address as the initial owner.
     */
    constructor(address initOwner) {
        _setOwner(initOwner);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Returns the address of the previous owner.
     */
    function previousOwner() public view virtual returns (address) {
        return _previousOwner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: The caller is not the owner!");
        _;
    }

    /**
     * @dev Leaves the contract without an owner. It won't be possible to call `onlyOwner` functions anymore.
     * Can only be called by the current owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _setOwner(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: The new owner is now, the zero address!");
        _setOwner(newOwner);
    }

    /**
     * @dev Sets the owner of the token to the given address.
     *
     * Emits an {OwnershipTransferred} event.
     */
    function _setOwner(address newOwner) private {
        _previousOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(_previousOwner, newOwner);
    }
}

/**
 * @dev Wrappers over Solidity's arithmetic operations.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, with an overflow flag.
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the benefit is lost if 'b' is also tested.
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }
}

/**
 * @dev The PancakeSwapV2 standards
 */
interface IPancakeRouter01 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);

    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);

    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);

    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);

    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);

    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline) external payable
    returns (uint[] memory amounts);

    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
    external
    returns (uint[] memory amounts);

    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
    external returns (uint[] memory amounts);

    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline) external payable
    returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);

    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);

    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);

    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);

    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

/**
 * @dev The PancakeSwapV2 standards
 */
interface IPancakeRouter02 is IPancakeRouter01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

/**
 * @dev The PancakeSwapV2 standards
 */
interface IPancakePair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);

    function symbol() external pure returns (string memory);

    function decimals() external pure returns (uint8);

    function totalSupply() external view returns (uint);

    function balanceOf(address owner) external view returns (uint);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);

    function transfer(address to, uint value) external returns (bool);

    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);

    function PERMIT_TYPEHASH() external pure returns (bytes32);

    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);

    function factory() external view returns (address);

    function token0() external view returns (address);

    function token1() external view returns (address);

    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);

    function price0CumulativeLast() external view returns (uint);

    function price1CumulativeLast() external view returns (uint);

    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);

    function burn(address to) external returns (uint amount0, uint amount1);

    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;

    function skim(address to) external;

    function sync() external;

    function initialize(address, address) external;
}

/**
 * @dev The PancakeSwapV2 standards
 */
interface IPancakeFactory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);

    function allPairs(uint) external view returns (address pair);

    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;
}

contract Archerweb is Context, IBEP20, Ownable {
    using SafeMath for uint256;

    //
    // Reward, fee and wallet related variables.
    //
    mapping(address => uint256) private _rewardOwned;
    mapping(address => uint256) private _tokenOwned;
    mapping(address => bool)    private _isExcludedFromFee;
    mapping(address => bool)    private _isExcluded;
    mapping(address => mapping(address => uint256)) private _allowances;

    address[] private _excluded;
    address public _devWallet;

    //
    // Summary of the fees
    //
    uint256 private _stakeFeeTotal;
    uint256 private _developerFeeTotal;
    uint256 private _eventFeeTotal;
    uint256 private _feeTotal;
    uint256 private _marketingFeeTotal;

    //
    // ArcherwebToken metadata
    //
    string private constant _tokenName = "Archerweb Token";
    string private constant _tokenSymbol = "AWT";
    uint8 private constant _tokenDecimals = 9;

    uint256 private constant MAX = ~uint256(0);
    uint256 private constant _totalSupply = 1000000000 * 10 ** uint256(_tokenDecimals);
    uint256 private _rewardSupply = (MAX - (MAX % _totalSupply));


    uint256 public _eventFee = 15;

    uint256 public _marketingFee = 20;

    uint256 public _developerFee = 20;

    uint256 public _stakeFee = 20;

    uint256 public _maxTxAmount = 1000000000 * 10 ** uint256(_tokenDecimals);

    //
    // Game/stake
    //
    mapping(address => uint256) private _playerPool;
    address public _playerPoolWallet;

    // A constant, used for checking the connection between the server and the contract.
    string private constant _pong = "PONG";

    //
    // Liquidity related fields.
    //

    // The address of the PancakeRouter
    address private constant _routerAddress = 0x10ED43C718714eb63d5aA57B78B54704E256024E;

    IPancakeRouter02 public _pancakeSwapV2Router;
    address public _pancakeSwapV2Pair;

    event EventFeeChanged(uint256 oldFee, uint256 newFee);
    event MarketingFeeChanged(uint256 oldFee, uint256 newFee);
    event DeveloperFeeChanged(uint256 oldFee, uint256 newFee);
    event StakeFeeChanged(uint256 oldFee, uint256 newFee);
    event DevWalletChanged(address oldAddress, address newAddress);
    event PlayerPoolChanged(address oldAddress, address newAddress);
    event PancakeRouterChanged(address oldAddress, address newAddress);
    event PancakePairChanged(address oldAddress, address newAddress);
    event MaxTransactionAmountChanged(uint256 oldAmount, uint256 newAmount);
    event Received(address sender, uint value);
    event FallBack(address sender, uint value);

    /**
    * @dev Executed on a call to the contract with empty call data.
    */
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    /**
    * @dev Executed on a call to the contract that does not match any of the contract functions.
    */
    fallback() external payable {
        emit FallBack(msg.sender, msg.value);
    }

    //
    // The token constructor.
    //

    constructor (address cOwner, address devWallet, address playerPoolWallet) Ownable(cOwner) {
        _devWallet = devWallet;
        _playerPoolWallet = playerPoolWallet;

        _rewardOwned[cOwner] = _rewardSupply;
        _pancakeSwapV2Router = IPancakeRouter02(_routerAddress);

        // Exclude the system addresses from the fee.
        _isExcludedFromFee[owner()] = true;
        _isExcludedFromFee[address(this)] = true;
        _isExcludedFromFee[_devWallet] = true;

        emit Transfer(address(0), cOwner, _totalSupply);
    }

    //
    // Contract Modules
    //

    struct Module {
        string moduleName;
        string moduleVersion;
        address moduleAddress;
    }

    Module[] private modules;

    event ModuleAdded(address moduleAddress, string moduleName, string moduleVersion);
    event ModuleRemoved(string moduleName);

    /**
    * @dev Adds a module to the contract with the given ModuleName and Version on the given ModuleAddress.
    */
    function addModule(string memory moduleName, string memory moduleVersion, address moduleAddress) external onlyOwner {
        Module memory module;
        module.moduleVersion = moduleVersion;
        module.moduleAddress = moduleAddress;
        module.moduleName = moduleName;

        bool added = false;
        for (uint256 i = 0; i < modules.length; i++) {
            if (keccak256(abi.encodePacked(modules[i].moduleName)) == keccak256(abi.encodePacked(moduleName))) {
                modules[i] = module;
                added = true;
            }
        }

        if (!added) {
            modules.push(module);

            emit ModuleAdded(moduleAddress, moduleName, moduleVersion);
        }
    }

    /**
    * @dev Removes a module from the contract.
    */
    function removeModule(string memory moduleName) external onlyOwner {
        uint256 index;
        bool found = false;
        for (uint256 i = 0; i < modules.length; i++) {
            if (keccak256(abi.encodePacked(modules[i].moduleName)) == keccak256(abi.encodePacked(moduleName))) {
                index = i;
                found = true;
            }
        }

        if (found) {
            modules[index] = modules[modules.length - 1];
            delete modules[modules.length - 1];
            modules.pop();

            emit ModuleRemoved(moduleName);
        }
    }

    /**
    * @dev Retrieves a 2-tuple (success? + search result) by the given ModuleName.
    */
    function getModule(string memory moduleName) external view returns (bool, Module memory) {
        Module memory result;
        bool found = false;
        for (uint256 i = 0; i < modules.length; i++) {
            if (keccak256(abi.encodePacked(modules[i].moduleName)) == keccak256(abi.encodePacked(moduleName))) {
                result = modules[i];
                found = true;
            }
        }
        return (found, result);
    }

    /**
    * @dev A modifier that requires the message sender to be the owner of the contract or a Module on the contract.
    */
    modifier onlyOwnerOrModule() {
        bool isModule = false;
        for (uint256 i = 0; i < modules.length; i++) {
            if (modules[i].moduleAddress == _msgSender()) {
                isModule = true;
            }
        }

        require(isModule || owner() == _msgSender(), "The caller is not the owner nor an authenticated Archerweb module!");
        _;
    }

    //
    // Game/Stake functions
    //

    /**
    * @dev Occasionally called (only) by the server to make sure that the connection with the contract is granted.
    */
    function ping() external view onlyOwnerOrModule returns (string memory) {
        return _pong;
    }

    /**
    * @dev A function used to withdraw from the player pool.
    */
    function withdraw(uint256 amount) external {
        require(_playerPool[_msgSender()] >= amount, "Invalid amount!");
        _transfer(_playerPoolWallet, _msgSender(), amount);
        _playerPool[_msgSender()] -= amount;
    }

    /**
    * @dev Retrieve the balance of a player from the player pool.
    */
    function balanceInPlayerPool(address playerAddress) external view returns (uint256) {
        return _playerPool[playerAddress];
    }

    /**
    * @dev Called by Game after a won / lost game, to set the new balance of a user in the player pool.
    * The gas price is provided by Game.
    */
    function setPlayerBalance(address playerAddress, uint256 balance) external onlyOwnerOrModule {
        _playerPool[playerAddress] = balance;
    }

    //
    // Reward and Token related functionalities
    //

    struct RewardValues {
        uint256 rAmount;
        uint256 rTransferAmount;
        uint256 rewardMarketingFee;
        uint256 rewardDeveloperFee;
        uint256 rewardEventFee;
        uint256 rewardStakeFee;
    }

    struct TokenValues {
        uint256 tTransferAmount;
        uint256 stakeFee;
        uint256 marketingFee;
        uint256 developerFee;
        uint256 eventFee;
    }

    /**
    * @dev Retrieves the Reward equivalent of the given Token amount. (With the Fees optionally included or excluded.)
    */
    function rewardFromToken(uint256 tAmount, bool deductTransferFee) public view returns (uint256) {
        require(tAmount <= _totalSupply, "The amount must be less than the supply!");

        if (!deductTransferFee) {
            uint256 currentRate = _getRate();
            (TokenValues memory tv) = _getTokenValues(tAmount, address(0));
            (RewardValues memory rv) = _getRewardValues(tAmount, tv, currentRate);

            return rv.rAmount;
        } else {
            uint256 currentRate = _getRate();
            (TokenValues memory tv) = _getTokenValues(tAmount, address(0));
            (RewardValues memory rv) = _getRewardValues(tAmount, tv, currentRate);

            return rv.rTransferAmount;
        }
    }

    /**
    * @dev Retrieves the Token equivalent of the given Reward amount.
    */
    function tokenFromReward(uint256 rAmount) public view returns (uint256) {
        require(rAmount <= _rewardSupply, "The amount must be less than the total rewards!");

        uint256 currentRate = _getRate();
        return rAmount.div(currentRate);
    }

    /**
    * @dev Excludes an address from the Reward process.
    */
    function excludeFromReward(address account) public onlyOwner {
        require(!_isExcluded[account], "The account is already excluded!");

        if (_rewardOwned[account] > 0) {
            _tokenOwned[account] = tokenFromReward(_rewardOwned[account]);
        }
        _isExcluded[account] = true;
        _excluded.push(account);
    }

    /**
    * @dev Includes an address in the Reward process.
    */
    function includeInReward(address account) external onlyOwner {
        require(_isExcluded[account], "The account is already included!");

        for (uint256 i = 0; i < _excluded.length; i++) {
            if (_excluded[i] == account) {
                _excluded[i] = _excluded[_excluded.length - 1];
                _tokenOwned[account] = 0;
                _isExcluded[account] = false;
                _excluded.pop();
                break;
            }
        }
    }

    /**
    * @dev Retrieves the Total Fees deducted to date.
    */
    function totalFees() public view returns (uint256) {
        return _feeTotal;
    }

    /**
    * @dev Retrieves the Total Marketing Fees deducted to date.
    */
    function totalMarketingFees() public view returns (uint256) {
        return _marketingFeeTotal;
    }

    /**
    * @dev Retrieves the Total Event Fees deducted to date.
    */
    function totalEventFees() public view returns (uint256) {
        return _eventFeeTotal;
    }

    /**
    * @dev Retrieves the Total Development Fees deducted to date.
    */
    function totalDevelopmentFees() public view returns (uint256) {
        return _developerFeeTotal;
    }

    /**
    * @dev Retrieves the Total Stake Service Fees deducted to date.
    */
    function totalStakeFees() public view returns (uint256) {
        return _stakeFeeTotal;
    }

    /**
    * @dev Excludes an address from the Fee process.
    */
    function excludeFromFee(address account) public onlyOwner {
        _isExcludedFromFee[account] = true;
    }

    /**
    * @dev Includes an address in the Fee process.
    */
    function includeInFee(address account) public onlyOwner {
        _isExcludedFromFee[account] = false;
    }

    /**
    * @dev Sets the given address as the Developer Wallet.
    */
    function setDevWallet(address devWallet) external onlyOwner {
        address oldAddress = _devWallet;
        _isExcludedFromFee[oldAddress] = false;
        _devWallet = devWallet;
        _isExcludedFromFee[_devWallet] = true;

        emit DevWalletChanged(oldAddress, _devWallet);
    }

    /**
    * @dev Sets the given address as the Player Pool Hot Wallet.
    */
    function setPlayerPoolWallet(address playerPoolWallet) external onlyOwner {
        address oldAddress = _playerPoolWallet;
        _playerPoolWallet = playerPoolWallet;

        emit PlayerPoolChanged(oldAddress, _playerPoolWallet);
    }

    /**
    * @dev Sets the Marketing Fee percentage.
    */
    function setMarketingFeePercent(uint256 marketingFee) external onlyOwner {
        uint256 oldFee = _marketingFee;
        _marketingFee = marketingFee;

        emit MarketingFeeChanged(oldFee, _marketingFee);
    }

    /**
    * @dev Sets the Developer Fee percentage.
    */
    function setDeveloperFeePercent(uint256 developerFee) external onlyOwner {
        uint256 oldFee = _developerFee;
        _developerFee = developerFee;

        emit DeveloperFeeChanged(oldFee, _developerFee);
    }

    /**
    * @dev Sets the Stake Service Fee percentage.
    */
    function setStakeFeePercent(uint256 stakeFee) external onlyOwner {
        uint256 oldFee = _stakeFee;
        _stakeFee = stakeFee;

        emit StakeFeeChanged(oldFee, _stakeFee);
    }

    /**
    * @dev Sets the Event Fee percentage.
    */
    function setEventFeePercent(uint256 eventFee) external onlyOwner {
        uint256 oldFee = _eventFee;
        _eventFee = eventFee;

        emit EventFeeChanged(oldFee, _eventFee);
    }

    /**
    * @dev Sets the maximum transaction amount. (calculated by the given percentage)
    */
    function setMaxTxPercent(uint256 maxTxPercent) external onlyOwner {
        uint256 oldAmount = _maxTxAmount;
        _maxTxAmount = _totalSupply.mul(maxTxPercent).div(100);

        emit MaxTransactionAmountChanged(oldAmount, _maxTxAmount);
    }

    /**
    * @dev Retrieves if the given address is excluded from the Fee process.
    */
    function isExcludedFromFee(address account) public view returns (bool) {
        return _isExcludedFromFee[account];
    }

    /**
    * @dev Retrieves if the given address is excluded from the Reward process.
    */
    function isExcludedFromReward(address account) public view returns (bool) {
        return _isExcluded[account];
    }

    /**
    * @dev Sets the given address as the Pancake Swap Router.
    */
    function setPancakeSwapRouter(address r) external onlyOwner {
        address oldRouter = address(_pancakeSwapV2Router);
        IPancakeRouter02 pancakeSwapV2Router = IPancakeRouter02(r);
        _pancakeSwapV2Router = pancakeSwapV2Router;

        emit PancakeRouterChanged(oldRouter, address(_pancakeSwapV2Router));
    }

    /**
    * @dev Sets the given address as the Pancake Swap Pair.
    */
    function setPancakeSwapPair(address p) external onlyOwner {
        address oldPair = _pancakeSwapV2Pair;
        _pancakeSwapV2Pair = p;

        emit PancakePairChanged(oldPair, _pancakeSwapV2Pair);
    }

    //
    // The Implementation of the IBEP20 Functions
    //

    /**
    * @dev Retrieves the Total Supply of the token.
    */
    function totalSupply() external pure override returns (uint256) {
        return _totalSupply;
    }

    /**
    * @dev Retrieves the Number of Decimal Points of the token.
    */
    function decimals() external pure override returns (uint8) {
        return _tokenDecimals;
    }

    /**
    * @dev Retrieves the Symbol of the token.
    */
    function symbol() external pure override returns (string memory) {
        return _tokenSymbol;
    }

    /**
    * @dev Retrieves the Name of the Token.
    */
    function name() external pure override returns (string memory) {
        return _tokenName;
    }

    /**
    * @dev Retrieves the Owner of the token.
    */
    function getOwner() external view override returns (address) {
        return owner();
    }

    /**
    * @dev Retrieves the Balance Of the given address.
    * Note: If the address is included in the Reward process, retrieves the Token equivalent of the held Reward amount.
    */
    function balanceOf(address account) public view override returns (uint256) {
        if (_isExcluded[account]) return _tokenOwned[account];
        return tokenFromReward(_rewardOwned[account]);
    }

    /**
    * @dev Transfers the given Amount of tokens (minus the fees, if any) from the
    * Message Senders wallet to the Recipients wallet.
    *
    * Note: If the Recipient is the Player Pool Hot Wallet, the Message Sender will be able to play with
    * the transferred amount of Tokens on.
    */
    function transfer(address recipient, uint256 amount) external override returns (bool) {
        if (recipient == _playerPoolWallet) {
            _playerPool[_msgSender()] += _transfer(_msgSender(), recipient, amount);
        } else {
            _transfer(_msgSender(), recipient, amount);
        }
        return true;
    }

    /**
    * @dev Retrieves the Allowance of the given Spender address in the given Owner wallet.
    */
    function allowance(address owner, address spender) external view override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
    * @dev Approves the given amount for the given Spender address in the Message Sender wallet.
    */
    function approve(address spender, uint256 amount) external override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    /**
    * @dev Transfers the given Amount of tokens from the Sender to the Recipient address
    * if the Sender approved on the Message Sender allowances.
    */
    function transferFrom(address sender, address recipient, uint256 amount) external override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "BEP20: The transfer amount exceeds the allowance."));
        return true;
    }

    //
    // Transfer and Approval processes
    //

    /**
    * @dev Approves the given amount for the given Spender address in the Owner wallet.
    */
    function _approve(address owner, address spender, uint256 amount) private {
        require(owner != address(0), "BEP20: Cannot approve from the zero address.");
        require(spender != address(0), "BEP20: Cannot approve to the zero address.");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Transfers from and to the given address the given amount of token.
     */
    function _transfer(address from, address to, uint256 amount) private returns (uint256) {
        require(from != address(0), "BEP20: Cannot transfer from the zero address.");
        require(to != address(0), "BEP20: Cannot transfer to the zero address.");
        require(amount > 0, "The transfer amount must be greater than zero!");

        if (from != owner() && to != owner()) {
            require(amount <= _maxTxAmount, "The transfer amount exceeds the maxTxAmount.");
        }

        bool takeFee = !(_isExcludedFromFee[from] || _isExcludedFromFee[to] || from == _playerPoolWallet);
        return _tokenTransfer(from, to, amount, takeFee);
    }

    /**
    * @dev Transfers the given Amount of tokens (minus the fees, if any) from the
    * Senders wallet to the Recipients wallet.
    */
    function _tokenTransfer(address sender, address recipient, uint256 amount, bool takeFee) private returns (uint256) {
        uint256 previousStakeFee = _stakeFee;
        uint256 previousDeveloperFee = _developerFee;
        uint256 previousEventFee = _eventFee;
        uint256 previousMarketingFee = _marketingFee;

        if (!takeFee) {
            _stakeFee = 0;
            _developerFee = 0;
            _eventFee = 0;
            _marketingFee = 0;
        }

        uint256 transferredAmount;
        if (_isExcluded[sender] && !_isExcluded[recipient]) {
            transferredAmount = _transferFromExcluded(sender, recipient, amount);
        } else if (!_isExcluded[sender] && _isExcluded[recipient]) {
            transferredAmount = _transferToExcluded(sender, recipient, amount);
        } else if (_isExcluded[sender] && _isExcluded[recipient]) {
            transferredAmount = _transferBothExcluded(sender, recipient, amount);
        } else {
            transferredAmount = _transferStandard(sender, recipient, amount);
        }

        if (!takeFee) {
            _stakeFee = previousStakeFee;
            _developerFee = previousDeveloperFee;
            _eventFee = previousEventFee;
            _marketingFee = previousMarketingFee;
        }

        return transferredAmount;
    }

    /**
    * @dev The Transfer function used when both the Sender and Recipient is included in the Reward process.
    */
    function _transferStandard(address sender, address recipient, uint256 tAmount) private returns (uint256) {
        uint256 currentRate = _getRate();
        (TokenValues memory tv) = _getTokenValues(tAmount, recipient);
        (RewardValues memory rv) = _getRewardValues(tAmount, tv, currentRate);

        _rewardOwned[sender] = _rewardOwned[sender].sub(rv.rAmount);
        _rewardOwned[recipient] = _rewardOwned[recipient].add(rv.rTransferAmount);

        takeTransactionFee(_devWallet, tv, currentRate, recipient);
        _rewardFee(rv);
        _countTotalFee(tv);
        emit Transfer(sender, recipient, tv.tTransferAmount);

        return tv.tTransferAmount;
    }

    /**
    * @dev The Transfer function used when both the Sender and Recipient is excluded from the Reward process.
    */
    function _transferBothExcluded(address sender, address recipient, uint256 tAmount) private returns (uint256) {
        uint256 currentRate = _getRate();
        (TokenValues memory tv) = _getTokenValues(tAmount, recipient);
        (RewardValues memory rv) = _getRewardValues(tAmount, tv, currentRate);

        _tokenOwned[sender] = _tokenOwned[sender].sub(tAmount);
        _rewardOwned[sender] = _rewardOwned[sender].sub(rv.rAmount);
        _tokenOwned[recipient] = _tokenOwned[recipient].add(tv.tTransferAmount);
        _rewardOwned[recipient] = _rewardOwned[recipient].add(rv.rTransferAmount);

        takeTransactionFee(_devWallet, tv, currentRate, recipient);
        _rewardFee(rv);
        _countTotalFee(tv);
        emit Transfer(sender, recipient, tv.tTransferAmount);

        return tv.tTransferAmount;
    }

    /**
    * @dev The Transfer function used when the Sender is included and the Recipient is excluded in / from the Reward process.
    */
    function _transferToExcluded(address sender, address recipient, uint256 tAmount) private returns (uint256) {
        uint256 currentRate = _getRate();
        (TokenValues memory tv) = _getTokenValues(tAmount, recipient);
        (RewardValues memory rv) = _getRewardValues(tAmount, tv, currentRate);

        _rewardOwned[sender] = _rewardOwned[sender].sub(rv.rAmount);
        _tokenOwned[recipient] = _tokenOwned[recipient].add(tv.tTransferAmount);
        _rewardOwned[recipient] = _rewardOwned[recipient].add(rv.rTransferAmount);

        takeTransactionFee(_devWallet, tv, currentRate, recipient);
        _rewardFee(rv);
        _countTotalFee(tv);
        emit Transfer(sender, recipient, tv.tTransferAmount);

        return tv.tTransferAmount;
    }

    /**
    * @dev The Transfer function used when the Sender is excluded and the Recipient is included from / in the Reward process.
    */
    function _transferFromExcluded(address sender, address recipient, uint256 tAmount) private returns (uint256) {
        uint256 currentRate = _getRate();
        (TokenValues memory tv) = _getTokenValues(tAmount, recipient);
        (RewardValues memory rv) = _getRewardValues(tAmount, tv, currentRate);

        _tokenOwned[sender] = _tokenOwned[sender].sub(tAmount);
        _rewardOwned[sender] = _rewardOwned[sender].sub(rv.rAmount);
        _rewardOwned[recipient] = _rewardOwned[recipient].add(rv.rTransferAmount);

        takeTransactionFee(_devWallet, tv, currentRate, recipient);
        _rewardFee(rv);
        _countTotalFee(tv);
        emit Transfer(sender, recipient, tv.tTransferAmount);

        return tv.tTransferAmount;
    }

    /**
    * @dev Takes the Reward Fees from the Reward Supply.
    */
    function _rewardFee(RewardValues memory rv) private {
        _rewardSupply = _rewardSupply.sub(rv.rewardMarketingFee).sub(rv.rewardDeveloperFee).sub(rv.rewardEventFee).sub(rv.rewardStakeFee);
    }

    /**
    * @dev Updates the Fee Counters by the Taken Fees.
    */
    function _countTotalFee(TokenValues memory tv) private {
        _marketingFeeTotal = _marketingFeeTotal.add(tv.marketingFee);
        _developerFeeTotal = _developerFeeTotal.add(tv.developerFee);
        _eventFeeTotal = _eventFeeTotal.add(tv.eventFee);
        _stakeFeeTotal = _stakeFeeTotal.add(tv.stakeFee);
        _feeTotal = _feeTotal.add(tv.marketingFee).add(tv.developerFee).add(tv.eventFee).add(tv.stakeFee);
    }

    /**
    * @dev Calculates the Token Values after taking the Fees.
    */
    function _getTokenValues(uint256 tAmount, address recipient) private view returns (TokenValues memory) {
        TokenValues memory tv;
        uint256 tTransferAmount = tAmount;

        if (recipient == _playerPoolWallet) {
            uint256 stakeFee = tAmount.mul(_stakeFee).div(10000);
            tTransferAmount = tTransferAmount.sub(stakeFee);

            tv.tTransferAmount = tTransferAmount;
            tv.stakeFee = stakeFee;

            return (tv);
        }

        uint256 marketingFee = tAmount.mul(_marketingFee).div(10000);
        uint256 developerFee = tAmount.mul(_developerFee).div(10000);
        uint256 eventFee = tAmount.mul(_eventFee).div(10000);
        tTransferAmount = tTransferAmount.sub(marketingFee).sub(developerFee).sub(eventFee);

        tv.tTransferAmount = tTransferAmount;
        tv.marketingFee = marketingFee;
        tv.developerFee = developerFee;
        tv.eventFee = eventFee;

        return (tv);
    }

    /**
    * @dev Calculates the Reward Values after taking the Fees.
    */
    function _getRewardValues(uint256 tAmount, TokenValues memory tv, uint256 currentRate) private pure returns (RewardValues memory) {
        RewardValues memory rv;

        uint256 rAmount = tAmount.mul(currentRate);
        uint256 rewardStakeFee = tv.stakeFee.mul(currentRate);
        uint256 rewardMarketingFee = tv.marketingFee.mul(currentRate);
        uint256 rewardDeveloperFee = tv.developerFee.mul(currentRate);
        uint256 rewardEventFee = tv.eventFee.mul(currentRate);
        uint256 rTransferAmount = rAmount.sub(rewardMarketingFee).sub(rewardDeveloperFee).sub(rewardEventFee).sub(rewardStakeFee);

        rv.rAmount = rAmount;
        rv.rTransferAmount = rTransferAmount;
        rv.rewardStakeFee = rewardStakeFee;
        rv.rewardMarketingFee = rewardMarketingFee;
        rv.rewardDeveloperFee = rewardDeveloperFee;
        rv.rewardEventFee = rewardEventFee;

        return (rv);
    }

    /**
    * @dev Retrieves the Rate between the Reward and Token Supply.
    */
    function _getRate() private view returns (uint256) {
        (uint256 rewardSupply, uint256 tokenSupply) = _getCurrentSupply();
        return rewardSupply.div(tokenSupply);
    }

    /**
    * @dev Retrieves the current Reward and Token Supply.
    */
    function _getCurrentSupply() private view returns (uint256, uint256) {
        uint256 rewardSupply = _rewardSupply;
        uint256 tokenSupply = _totalSupply;
        for (uint256 i = 0; i < _excluded.length; i++) {
            if (_rewardOwned[_excluded[i]] > rewardSupply || _tokenOwned[_excluded[i]] > tokenSupply) return (_rewardSupply, _totalSupply);
            rewardSupply = rewardSupply.sub(_rewardOwned[_excluded[i]]);
            tokenSupply = tokenSupply.sub(_tokenOwned[_excluded[i]]);
        }
        if (rewardSupply < _rewardSupply.div(_totalSupply)) return (_rewardSupply, _totalSupply);
        return (rewardSupply, tokenSupply);
    }

    /**
    * @dev Takes the given Fees.
    */
    function takeTransactionFee(address to, TokenValues memory tv, uint256 currentRate, address recipient) private {
        uint256 totalFee = recipient == _playerPoolWallet ? (tv.stakeFee) : (tv.marketingFee + tv.developerFee + tv.eventFee);

        if (totalFee <= 0) {return;}

        uint256 rAmount = totalFee.mul(currentRate);
        _rewardOwned[to] = _rewardOwned[to].add(rAmount);
        if (_isExcluded[to]) {
            _tokenOwned[to] = _tokenOwned[to].add(totalFee);
        }
    }
}
