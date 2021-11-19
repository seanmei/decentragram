const { assert } = require('chai')

const Decentragram = artifacts.require('./Decentragram.sol')

require('chai')
  .use(require('chai-as-promised'))
  .should()

contract('Decentragram', ([deployer, author, tipper]) => {
  let decentragram

  before(async () => {
    decentragram = await Decentragram.deployed()
  })

  describe('deployment', async () => {
    it('deploys successfully', async () => {
      const address = await decentragram.address
      //checks that the address exists 
      assert.notEqual(address, 0x0)
      assert.notEqual(address, '')
      assert.notEqual(address, null)
      assert.notEqual(address, undefined)
    })

    it('has a name', async () => {
      const name = await decentragram.name()
      assert.equal(name, 'Decentragram')
    })
  }) 

  describe('images', async () => {
    let result, imageCount
    const hash = 'abc123'

    before(async () => {
      result = await decentragram.uploadImage(hash,'Image Description', {from: author} );
      imageCount = await decentragram.imageCount();
    })
    it('creates images', async () => {
      //Success
      assert.equal(imageCount, 1)
      const event = result.logs[0].args //gets data from the event in the function
      
      assert.equal(event.id.toNumber(), imageCount.toNumber(), 'id is correct')
      assert.equal(event.hash, hash, "Hash is correct")
      assert.equal(event.description, "Image Description", 'description is correct')
      assert.equal(event.tipAmount, '0', 'tip amount is correct')
      assert.equal(event.author, author, 'author is correct')

      //Failure: Image must have a hash 
      await decentragram.uploadImage('', 'Image Description', { from: author }).should.be.rejected;

      //Failure: Image must have a description 
      await decentragram.uploadImage('abc123', '', { from: author }).should.be.rejected;

    })

    //check from struct 
    it('lists images', async () => {
        const image = await decentragram.images(imageCount)
        assert.equal(image.id.toNumber(), imageCount.toNumber(), 'id is correct')
        assert.equal(image.hash, hash, 'Hash is correct')
        assert.equal(image.description, 'Image Description', 'description is correct')
        assert.equal(image.tipAmount, '0', 'tip amount is correct')
        assert.equal(image.author, author, 'author is correct')

    })

  })
})