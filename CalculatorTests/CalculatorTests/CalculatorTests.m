#import "CalculatorTests.h"
#import "Calculator.h"

@implementation CalculatorTests

- (void)setUp {
    [super setUp];
    sut = [[Calculator alloc] init];
}

- (void)tearDown {
    [sut release];
    [super tearDown];
}

- (void)testAddMethod_ZeroLengthInput_ReturnsZero {
    int result = [sut add:@""];
    int expected = 0;

    STAssertEquals(expected, result, @"Zero length input should return zero");
}

- (void)testAddMethod_OneLengthInput_ReturnsEquivalent {
    int result = [sut add:@"4"];
    int expected = 4;

    STAssertEquals(expected, result, @"One length input should return equivalent");
}

- (void)testAddMethod_TwoLengthInput_ReturnsSum {
    int result = [sut add:@"4,3"];
    int expected = 7;

    STAssertEquals(expected, result, @"Two length input should return sum");
}

- (void)testAddMethod_AnyLengthInput_ReturnsSum {
    int howMany = arc4random() % 999;
    int expected = 0;
    NSMutableString *numbersToAdd = [NSMutableString string];

    for(int i = 0; i < howMany; i++) {
        [numbersToAdd appendString:[NSString stringWithFormat:@"%d,",i]];
        expected += i;
    }

    int result = [sut add:numbersToAdd];

    STAssertEquals(expected, result, @"Any length input should return sum");
}

- (void)testAddMethod_NewLineDelimiterInput_ReturnsSum {
    int result = [sut add:@"4,3\n8"];
    int expected = 15;

    STAssertEquals(expected, result, @"New line delimiter input should return sum");
}

- (void)testAddMethod_DuplicateDelimitersInput_ThrowsException {
    STAssertThrowsSpecificNamed([sut add:@"3\n,4,5"], NSException, @"DuplicateDelimitersException", @"You cannot input duplicate delimiters.");
}


- (void)dealloc {
    [super dealloc];
}


@end
